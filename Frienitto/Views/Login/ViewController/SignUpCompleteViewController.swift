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
        
        showActivityIndicator()
        
        let provider = FrienttoProvider()
        guard let name = nameTextField.text,
            let description = descriptionTextField.text,
            let email = email,
            let password = password else { return }
        let imageCode = Int.random(in: 1...6)
        
        provider.signUp(username: name,
                        description: description,
                        imageCode: imageCode,
                        email: email,
                        password: password,
                        completion: { [weak self] SignUpModel in
            self?.navigationController?.popToRootViewController(animated: true)
        }) { error in
            print(error.localizedDescription)
        }
    }
}
