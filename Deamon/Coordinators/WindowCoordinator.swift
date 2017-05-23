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
        
        let mainWindow = NSApplication.shared().windows.first(where: { $0 is DeamonWindow})
        let receiverView = (mainWindow?.contentViewController as? ViewController)?.receiverView
        let viewModel = ReceiverViewModel(shouldRegister: false, disableTextField: false, textViewResult: result)
        
        receiverView?.load(with: viewModel)
    }
}
