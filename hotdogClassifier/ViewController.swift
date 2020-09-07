//
//  ViewController.swift
//  hotdogClassifier
//
//  Created by Swamita on 07/09/20.
//  Copyright © 2020 Swamita Gupta. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }

    @IBAction func cameraTapped(_ sender: Any) {
    }
    
}

