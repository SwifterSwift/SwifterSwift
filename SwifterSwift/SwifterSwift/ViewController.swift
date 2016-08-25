//
//  ViewController.swift
//  SwifterSwift
//
//  Created by Omar Albeik on 8/24/16.
//  Copyright © 2016 Omar Albeik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.cornerRadius = 50
        imageView.download(from: "https://cdn.spacetelescope.org/archives/images/screen/heic0107a.jpg")
    }

}

