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
    @IBOutlet weak var resultLabel: UILabel!
    var classificationResults : [VNClassificationObservation] = []
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
    }
    
    func detect(image: CIImage) {
       
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            fatalError("can't load ML model")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation],
                let topResult = results.first
                else {
                    fatalError("unexpected result type from VNCoreMLRequest")
            }
            
            if topResult.identifier.contains("hotdog") {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Hotdog! 🌭😍"
                    self.resultLabel.backgroundColor = UIColor.green
                }
            }
                
            else if topResult.identifier.contains("pizza") {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Pizza! 🍕❤️"
                    self.resultLabel.backgroundColor = UIColor.green
                }
            }
            else {
                DispatchQueue.main.async {
                    self.resultLabel.text = "Neither Hotdog nor Pizza! ❌😟"
                    self.resultLabel.backgroundColor = UIColor.red
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[.originalImage] as? UIImage {
            
            imageView.image = image
            imagePicker.dismiss(animated: true, completion: nil)
            guard let ciImage = CIImage(image: image) else {
                fatalError("couldn't convert uiimage to CIImage")
            }
            detect(image: ciImage)
        }
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = false
                present(imagePicker, animated: true, completion: nil)
            }
            
        }

        fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
            return input.rawValue
        }
