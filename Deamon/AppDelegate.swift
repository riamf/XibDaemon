//
//  AppDelegate.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 08/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        NSApplication.shared().windows.first?.orderOut(self)
        
        let statusBarItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
//        statusBarItem.menu = NSMenu()
        statusBarItem.isVisible = true
        statusBarItem.isEnabled = true
        
        statusBarItem.title = "Presses"
        statusBarItem.action = #selector(checkApps)
        statusBarItem.target = self
        statusBarItem.highlightMode = true
        statusItem = statusBarItem
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    func checkApps() {
        print("checking...")
        NSWorkspace.shared().runningApplications.forEach { (app) in
            let name = app.localizedName?.lowercased() ?? ""
            print(name)
            
            if name == "xcode" {
                print("znalazl sie")
            }
        }
        
    }


}

