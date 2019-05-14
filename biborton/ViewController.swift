//
//  ViewController.swift
//  biborton
//
//  Created by Tasauf Mim on 13/5/19.
//  Copyright © 2019 Tasauf Mim. All rights reserved.
//

import UIKit
import TesseractOCR

class ViewController: UIViewController, G8TesseractDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let image = UIImage(named: "bangla")
    var imagePicked = false
    var recognizedText = "বাংলাদেশ"

    var tesseract: G8Tesseract = G8Tesseract(language: "ben")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recognizedText = "বাংলাদেশ"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func pickButtonClicked(_ sender: Any) {
        view.endEditing(true)
        presentImagePicker()
        imagePicked = true
    }
    
    @IBAction func extractButtonClicked(_ sender: Any) {
        tesseract.delegate = self
        
        tesseract.pageSegmentationMode = .auto
        tesseract.image = imageView.image?.g8_blackAndWhite()
        tesseract.recognize()
        
        recognizedText = tesseract.recognizedText
        performSegue(withIdentifier: "dataSeg", sender: self)
        
        if imagePicked == false {
            //dispaly error HUD
            recognizedText = "You didn't Picked Any Image!!!!\nPlease pick/take an Image then Extract"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let textScreen = segue.destination as! TextScreenController
        textScreen.recognizedText = recognizedText
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentImagePicker() {
        
        let imagePickerActionSheet = UIAlertController(title: "Photo Source",
                                                       message: nil, preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Camera",
                                             style: .default) { (alert) -> Void in
                                                let imagePicker = UIImagePickerController()
                                                imagePicker.delegate = self
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker, animated: true)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        let libraryButton = UIAlertAction(title: "Photo Library",
                                          style: .default) { (alert) -> Void in
                                            let imagePicker = UIImagePickerController()
                                            imagePicker.delegate = self
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker, animated: true)
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        
        present(imagePickerActionSheet, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let selectedPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = selectedPhoto
            picker.dismiss(animated: true, completion: nil)
        }
    }
}


