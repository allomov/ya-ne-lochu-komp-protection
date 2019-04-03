//
//  AppDelegate.swift
//  ya-ne-lochu-komp
//
//  Created by Alex Lomov on 3/31/19.
//  Copyright © 2019 Alex Lomov. All rights reserved.
//

import Cocoa
import AVFoundation

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let mainWindowController = NSWindowController()
    let keylogger = Keylogger()
    var keysPressedCount = 0
    var screaming = false
    let newWindowController = WindowController()
    var player:AVAudioPlayer?



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
        }
        constructMenu()
        registerPressKeyboardObserver()
        keylogger.start()

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func pressKeyboardCallback() {
        print("keysPressedCount")
        print(keysPressedCount)
        // for some reason the callback is called 8 times per key press
        if (keysPressedCount > 12 * 8 && !screaming) {
            scream()
        }
        keysPressedCount = keysPressedCount + 1;
    }


    func playSound() {
        let url = Bundle.main.url(forResource: "scream", withExtension: "wav")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    func scream() {
        screaming = true
        
        playSound()
        
        newWindowController.showWindow(nil)
        newWindowController.window?.orderFrontRegardless()
        
        print("AAAAA-AAAAA-AAAAAAAAAAAAAAA")

        keysPressedCount = 0
        screaming = false
    }

    func constructMenu() {
        let menu = NSMenu()

        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit Screamer", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
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

