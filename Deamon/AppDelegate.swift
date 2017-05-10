//
//  AppDelegate.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 08/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Cocoa
import ApplicationServices
import Carbon

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var statusItem: NSStatusItem!
    var uiElement: AXUIElement!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        NSApplication.shared().windows.first?.orderOut(self)
        
        statusItem = addStatusBarItem()
        
        askAccessibilityPermissions()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func addStatusBarItem() -> NSStatusItem {
        
        let statusBarItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)
        statusBarItem.isVisible = true
        statusBarItem.isEnabled = true
        statusBarItem.title = "Presses"
        statusBarItem.action = #selector(checkApps)
        statusBarItem.target = self
        statusBarItem.highlightMode = true
        return statusBarItem
    }
    
    func askAccessibilityPermissions() {
        
        if !AXIsProcessTrusted() {
            
            let alert = NSAlert()
            alert.addButton(withTitle: "OK")
            alert.addButton(withTitle: "Go to Settings")
            alert.addButton(withTitle: "Cancel")
            alert.informativeText = "Would you like to launch System Preferences so that you can turn on \"Enable access for assistive devices\"?"
            alert.alertStyle = .warning
            let alertResult = alert.runModal()
            
            switch alertResult {
            case NSAlertSecondButtonReturn:
                let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.preferencePanesDirectory, FileManager.SearchPathDomainMask.systemDomainMask, true)
                if paths.count == 1 {
                    let url = URL(fileURLWithPath: paths.first!.appending("/UniversalAccessPref.prefPane"))
                    NSWorkspace.shared().open(url)
                }
            default:
                NSApp.terminate(self)
                break
            }
        }
        
        uiElement = createUIElement()
    }
    
    func createUIElement() -> AXUIElement {
        return AXUIElementCreateSystemWide()
    }
    
    
    func checkApps() {
        print("checking...")
        NSWorkspace.shared().runningApplications.forEach { (app) in
            let name = app.localizedName?.lowercased() ?? ""
            
            if name == "xcode" {
                let cocoaPoint = NSEvent.mouseLocation()
                guard let screens = NSScreen.screens() else { return }
                var foundScreen: NSScreen? = nil
                for screen: NSScreen in screens {
                    if screen.frame.contains(cocoaPoint) {
                        foundScreen = screen
                        break
                    }
                }
                var point: CGPoint = .zero
                if let foundScreen = foundScreen {
                    let height = foundScreen.frame.size.height
                    point = CGPoint(x: cocoaPoint.x, y: height - cocoaPoint.y - 1)
                }
                
                var newElement: AXUIElement? = nil
                
                if AXUIElementCopyElementAtPosition(uiElement,
                                                 Float(point.x),
                                                 Float(point.y),
                                                 &newElement) == AXError.success {
                    
                    guard let element = newElement else { return }
                    
                    var attribues = NSArray()
                    var cfa = attribues as CFArray?
                    
                    AXUIElementCopyAttributeNames(element, &cfa)
                    
                    var actionNames = NSArray()
                    var cfan = actionNames as CFArray?
                    
                    AXUIElementCopyActionNames(element, &cfan)
                    
                    print("something \(attribues) - \(actionNames)")
                    
                    
                }
            }
        }
    }


}

