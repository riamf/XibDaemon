//
//  Parser.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 14/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Foundation
import AEXML
import Cocoa

protocol Parser {
    func parse(url: URL)
}

class XMLParser: Parser {
    
    enum XIBAttribute {
        static let customClass = "customClass"
        static let userLabel = "userLabel"
    }
    
    enum XIBElements {
        static let objects = "objects"
        static let placeholder = "placeholder"
        static let subviews = "subviews"
        static let tableViewCellContentView = "tableViewCellContentView"
    }
    
    func parse(url: URL) {
        guard let data = try? Data(contentsOf: url) else { return }
        guard let xml = try? AEXMLDocument(xml: data) else { return }
        
        let activeDesigns = xml.root[XIBElements.objects].children.filter({ $0.name != XIBElements.placeholder })
        
        for design in activeDesigns {
            
            let className = design.attributes[XIBAttribute.customClass] ??
                url.lastPathComponentWithoutExtension
            let viewModelType = "\(className)ViewModel"
            let superClass = design.className
            let subviews = design[XIBElements.subviews]
            
            var resulting = "class \(className): \(superClass) { \r\n \r\n"
            
            for (index,view) in subviews.children.enumerated() {
                let subviewType = view.attributes[XIBAttribute.customClass] ?? view.className
                let name = view.attributes[XIBAttribute.userLabel] ?? "outlet_\(index)"

                resulting += "\t @IBOutlet private weak var \(name): \(subviewType)!\r\n"
            }
            
            resulting += "\r\n \t func load(viewModel viewModel: \(viewModelType)) {\r\n"
            
            resulting += "\t }\r\n}\r\n \r\n"
            
            resulting += "struct \(viewModelType) { \r\n"
            resulting += "\t \r\n}\r\n"
            
            windowCoordinator.displayWindow(with: resulting)
        }
    }
}

extension XMLParser: WindowCoordinatorAccessible {}

fileprivate extension AEXMLElement {
    var className: String {
        return name
    }
}

fileprivate extension URL {
    var lastPathComponentWithoutExtension: String {
        return lastPathComponent.replacingOccurrences(of: ".\(pathExtension)", with: "")
    }
}
