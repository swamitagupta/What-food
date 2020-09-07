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
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            imageView.image = userPickedImage
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
                        
    }

    @IBAction func cameraTapped(_ sender: Any) {
        present(imagePicker, animated: true, completion: nil)
    }
    
}

