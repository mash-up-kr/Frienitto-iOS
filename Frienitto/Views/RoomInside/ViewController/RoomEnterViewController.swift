//
//  RoomEnterViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 12/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class RoomEnterViewController: UIViewController {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var codeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
    }
    
    @IBAction func joinRoom(_ sender: UIButton) {
        guard let title = titleTextField.text,
            let code = codeTextField.text else { return }
        
        showActivityIndicator()
        let provider = FrienttoProvider()
        
        provider.joinRoom(title: title, code: code, completion: { [weak self] joinRoomModel in
            
            guard let peopleMatchViewController = UIStoryboard.instantiate(PeopleMatchViewController.self, name: "RoomInside") else { return }
            peopleMatchViewController.room = joinRoomModel.data
            
            self?.navigationController?.pushViewController(peopleMatchViewController, animated: true)
        }, failure: { error, _ in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
