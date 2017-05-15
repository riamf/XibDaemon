//
//  AppDelegate.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 08/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Cocoa
import ApplicationServices

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem!
    var uiElement: AXUIElement!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification)    {
        // Insert code here to tear down your application
    }
}
