//
//  TextScreenController.swift
//  biborton
//
//  Created by Tasauf Mim on 13/5/19.
//  Copyright © 2019 Tasauf Mim. All rights reserved.
//

import UIKit

class TextScreenController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    var recognizedText = "বাংলাদেশ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = recognizedText
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}
