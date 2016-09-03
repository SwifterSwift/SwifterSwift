//
//  ViewController.swift
//  SwifterSwiftExample
//
//  Created by Omar Albeik on 9/3/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit
import SwifterSwift

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		var arr = [1, 2, 3, 4, 5]
		arr.removeDuplicates()
		print(arr)
	}

}

