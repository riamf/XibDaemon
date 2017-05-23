//
//  ViewController.swift
//  Deamon
//
//  Created by Pawel Kowalczuk on 08/05/2017.
//  Copyright © 2017 Pawel Kowalczuk. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet private weak var resetButton: NSButton!
    var receiverView: ReceiverView? {
        return (view as? ReceiverView)
    }
    
    var receiverViewModel: ReceiverViewModel = ReceiverViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        receiverView?.load(with: receiverViewModel)
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    @IBAction fileprivate func resetContent(_ sender: NSButton) {
        receiverView?.load(with: receiverViewModel)
    }
}
