//
//  ViewController.swift
//  SwiftierSwift
//
//  Created by Omar Albeik on 8/5/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var testView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func shakeButtonTapped(_ sender: UIButton) {
        testView.rotate(byAngle: 90, ofType: .degrees, animated: true)
    }
}

