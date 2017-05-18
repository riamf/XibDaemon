//
//  WindowCoordinator.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 17/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Cocoa

protocol WindowCoordinatorAccessible {
    var windowCoordinator: WindowCoordinatorType { get }
}

extension WindowCoordinatorAccessible {
    var windowCoordinator: WindowCoordinatorType {
        return (NSApplication.shared().delegate as! AppDelegate).windowCoordinator
    }
}

protocol WindowCoordinatorType {
    func displayWindow(with result: String)
}

class WindowCoordinator: WindowCoordinatorType {
    
    var presentingWindow: NSWindow?
    
    func displayWindow(with result: String) {
        print(result)
        
        let frame = NSRect(x: 0, y: 0, width: 200, height: 200)
        presentingWindow = NSWindow(contentRect: frame,
                                    styleMask: .borderless,
                                    backing: .buffered, defer: false)
        
        presentingWindow?.backgroundColor = NSColor.blue
        presentingWindow?.makeKeyAndOrderFront(NSApp)
    }
}
