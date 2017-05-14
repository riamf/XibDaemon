//
//  ReceiverView.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 14/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Cocoa

class ReceiverView: NSView {
    
    enum AcceptableTypes {
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
    
    private let filteringOptions = [NSPasteboardURLReadingContentsConformToTypesKey: NSFileContentsPboardType]
    
    private var acceptableTypes: [String] {
        return [NSURLPboardType]
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private var isReceivingDrag = false {
        didSet {
            needsDisplay = true
        }
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        if isReceivingDrag {
            NSColor.selectedControlColor.set()
            let path = NSBezierPath(rect: bounds)
            path.lineWidth = 8.0
            path.stroke()
        }
        // Drawing code here.
    }
    
    private func setup() {
       register(forDraggedTypes: acceptableTypes)
    }
    
    private func shouldAllowDrag(_ draggingInfo: NSDraggingInfo) -> Bool {
     
        var canAccept = false
        
        let pasteBoard = draggingInfo.draggingPasteboard()
        
        if let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options: nil) as? [URL],
            urls.count > 0, AcceptableTypes.isAcceptable(urls.first?.pathExtension) {
            canAccept = true
        }
        
        return canAccept
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        
        isReceivingDrag = false
        
        let pasteBoard = sender.draggingPasteboard()
        
        if let urls = pasteBoard.readObjects(forClasses: [NSURL.self], options: nil) as? [URL],
            urls.count > 0 {
         return true
        }
        return false
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        let allow = shouldAllowDrag(sender)
        return allow
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        isReceivingDrag = false
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let allow = shouldAllowDrag(sender)
        isReceivingDrag = allow
        return allow ? .copy : NSDragOperation()
    }
}
