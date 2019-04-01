//
//  ViewController.swift
//  ya-ne-lochu-komp
//
//  Created by Alex Lomov on 3/31/19.
//  Copyright © 2019 Alex Lomov. All rights reserved.
//

import Cocoa

class ScreamerViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.window?.toggleFullScreen(self)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

extension ScreamerViewController {
    // MARK: Storyboard instantiation
    static func freshController() -> ScreamerViewController {
        //1.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        //2.
        let identifier = NSStoryboard.SceneIdentifier("ScreamerViewController")
        //3.
        guard let viewcontroller = storyboard.instantiateController(withIdentifier: identifier) as? ScreamerViewController else {
            fatalError("Why cant i find QuotesViewController? - Check Main.storyboard")
        }
        return viewcontroller
    }
}
