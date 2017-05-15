//
//  ReceiverView.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 14/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Cocoa

class ReceiverView: NSView {
    
    fileprivate let dragAndDropCoordinator: DragAndDropCoordinatorType = DragAndDropCoordinator(parser: XMLParser())
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    fileprivate var isReceivingDrag = false {
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
    }
}
//MARK: Dragging
extension ReceiverView {
    
    fileprivate func setup() {
        register(forDraggedTypes: dragAndDropCoordinator.acceptableTypes)
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        
        isReceivingDrag = false
        return dragAndDropCoordinator.performDragOperation(sender)
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return dragAndDropCoordinator.prepareForDragOperation(sender)
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        isReceivingDrag = false
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let result = dragAndDropCoordinator.draggingEntered(sender)
        isReceivingDrag = result.1
        return result.0
    }
}
