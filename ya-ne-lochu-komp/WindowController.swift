//
//  WindowController.swift
//  ya-ne-lochu-komp
//
//  Created by Alex Lomov on 4/3/19.
//  Copyright © 2019 Alex Lomov. All rights reserved.
//

import Cocoa

class WindowController: NSWindowController {

    convenience init() {
        self.init(windowNibName: "WindowController")
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.


//        self.window?.orderFront(self)

//        self.window?.backgroundColor = NSColor.black
//        self.window?.makeKeyAndOrderFront(self)
//        self.window?.makeFirstResponder(self)

        shakeWindow()
    }
    
    //    https://stackoverflow.com/questions/10056528/shake-window-when-user-enter-wrong-password-from-code
    func shakeWindow() {
        
        let numberOfShakes:Int = 20
        let durationOfShake:Float = 1
        let vigourOfShake:Float = 0.05
        
        let frame:CGRect = (self.window!.frame)
        let shakeAnimation = CAKeyframeAnimation()
        
        let shakePath = CGMutablePath()
        shakePath.move(to: CGPoint(x: NSMinX(frame), y: NSMinY(frame)))
        
        for _ in 1...numberOfShakes {
            shakePath.addLine(to: CGPoint(x:NSMinX(frame) - frame.size.width * CGFloat(vigourOfShake), y: NSMinY(frame)))
            shakePath.addLine(to: CGPoint(x:NSMinX(frame) + frame.size.width * CGFloat(vigourOfShake), y: NSMinY(frame)))
        }
        
        shakePath.closeSubpath()
        shakeAnimation.path = shakePath
        shakeAnimation.duration = CFTimeInterval(durationOfShake)
        self.window?.animations = ["frameOrigin":shakeAnimation]
        self.window?.animator().setFrameOrigin((self.window?.frame.origin)!)
    }
    
    
}
