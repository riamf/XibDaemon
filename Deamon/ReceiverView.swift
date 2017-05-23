//
//  ReceiverView.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 14/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Cocoa

class ReceiverView: NSView {
    
    @IBOutlet private weak var textView: NSTextView!
    
    fileprivate let dragAndDropCoordinator: DragAndDropCoordinatorType = DragAndDropCoordinator(parser: XMLParser())
    
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
    
    func load(with viewModel: ReceiverViewModel) {
        
        textView.isHidden = viewModel.disableTextField
        textView.string = viewModel.textViewResult
        viewModel.shouldRegister ? register() : unregister()
    }
}
//MARK: Dragging
extension ReceiverView {
    
    fileprivate func register() {
        register(forDraggedTypes: dragAndDropCoordinator.acceptableTypes)
    }
    
    fileprivate func unregister() {
        unregisterDraggedTypes()
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
