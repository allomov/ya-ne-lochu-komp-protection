//
//  AppDelegate.swift
//  ya-ne-lochu-komp
//
//  Created by Alex Lomov on 3/31/19.
//  Copyright © 2019 Alex Lomov. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let mainWindowController = NSWindowController()
    let keylogger = Keylogger()
    var keysPressedCount = 0


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(printQuote(_:))
        }
        constructMenu()
        keysPressedCount = -1
        registerPressKeyboardObserver()
        keylogger.start()

        //        popover.contentViewController = ScreamerViewController.freshController()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func pressKeyboardCallback() {
        print("keysPressedCount")
        print(keysPressedCount)
        if (keysPressedCount > 5) {
//            scream()
        }
        keysPressedCount = keysPressedCount + 1;
    }

    func scream() {
        print("AAAAA")
    }
    
    @objc func printQuote(_ sender: Any?) {
//        mainWindowController = self.storyboard?.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("mainWindowController"))
//            as! NSViewController
//        self.view.window?.contentViewController = vcStores
        
//        let quoteText = "Never put off until tomorrow what you can do the day after tomorrow."
//        let quoteAuthor = "Mark Twain"
//
//        print("\(quoteText) — \(quoteAuthor)")
    }

    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Print Quote", action: #selector(AppDelegate.printQuote(_:)), keyEquivalent: "P"))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Quotes", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }

    func registerPressKeyboardObserver() {
        let observer = UnsafeMutableRawPointer(Unmanaged.passUnretained(self).toOpaque())
        IOHIDManagerRegisterInputValueCallback(keylogger.manager, {
            (context, _, _, _) -> Void in
            if let observerToConvert = context {
                let mySelf = Unmanaged<AppDelegate>.fromOpaque(observerToConvert).takeUnretainedValue()
                mySelf.pressKeyboardCallback()
            }
        }, observer);
    }
}

