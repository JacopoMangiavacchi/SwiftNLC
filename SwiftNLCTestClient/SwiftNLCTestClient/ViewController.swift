//
//  ViewController.swift
//  SwiftNLCTestClient
//
//  Created by Jacopo Mangiavacchi on 3/12/18.
//  Copyright © 2018 Jacopo Mangiavacchi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var intentLabel: UILabel!
    @IBOutlet weak var commandField: UITextField!
    
    let model = SwiftNLCModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        commandField.delegate = self
        intentLabel.text = ""
        commandField.becomeFirstResponder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func go(_ sender: Any) {
        print(commandField.text!)
        
        if let prediction = model.predict(commandField.text!) {
            intentLabel.text = "\(prediction.0) (\(String(format: "%2.1f", prediction.1 * 100))%)"
        }
        else {
            intentLabel.text = "error"
        }

        commandField.resignFirstResponder()
    }
    
}

