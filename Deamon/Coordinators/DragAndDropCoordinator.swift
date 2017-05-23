//
//  DragAndDropCoordinator.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 14/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Cocoa

protocol DragAndDropCoordinatorType {
    
    var acceptableTypes: [String] { get }
    
    func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool
    func performDragOperation(_ sender: NSDraggingInfo) -> Bool
    func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool
    func draggingEntered(_ sender: NSDraggingInfo) -> (NSDragOperation, Bool)
}

class DragAndDropCoordinator: DragAndDropCoordinatorType {
    
    let parser: Parser
    
    init(parser: Parser) {
        self.parser = parser
    }
    
    var acceptableTypes: [String] {
        return [NSURLPboardType]
    }
    
    func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
        
        var canAccept = false
        
        let pasteBoard = draggingInfo.draggingPasteboard()
        
        if let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options: nil) as? [URL],
            urls.count > 0, AcceptableTypes.isAcceptable(urls.first?.pathExtension) {
            canAccept = true
        }
        
        return canAccept
    }
    
    func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        
        let pasteBoard = sender.draggingPasteboard()
        
        if let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options: nil) as? [URL],
            let first = urls.first {
            parser.parse(url: first)
            return true
        }
        return false
    }
    
    func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let allow = shouldAllowDrag(sender)
        return allow
    }
    
    func draggingEntered(_ sender: NSDraggingInfo) -> (NSDragOperation, Bool) {
        let allow = shouldAllowDrag(sender)
        return allow ? (.copy, allow) : (NSDragOperation(), allow)
    }
    
    private enum AcceptableTypes {
        static let xib = "xib"
        static let storyboard = "storyboard"
        private static var allTypes: [String] {
            return [AcceptableTypes.xib, AcceptableTypes.storyboard]
        }
        
        static func isAcceptable(_ type: String?) -> Bool {
            guard let type = type else { return false }
            return AcceptableTypes.allTypes.contains(type.lowercased())
        }
    }
    
}
