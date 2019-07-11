//
//  SignUpCompleteViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 30/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class SignUpCompleteViewController: UIViewController {
    
    var email: String?
    var password: String?
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func confirm(_ sender: UIButton) {
        let provider = FrienttoProvider()
        guard let name = nameTextField.text,
            let description = descriptionTextField.text,
            let email = email,
            let password = password else { return }
        provider.signUp(username: name, description: description, imageCode: 1, email: email, password: password, completion: { response in
            
            print(try? response?.mapJSON())
        }, failure: { error in
            print(error.localizedDescription)
        })
    }
}
