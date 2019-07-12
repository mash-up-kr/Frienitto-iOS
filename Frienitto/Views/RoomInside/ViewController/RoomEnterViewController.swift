//
//  RoomEnterViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 12/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class RoomEnterViewController: UIViewController {

    @IBOutlet var codeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
        super.viewWillAppear(animated)
    }
    
    @IBAction func joinRoom(_ sender: UIButton) {
        guard let peopleMatchViewController = UIStoryboard.instantiate(PeopleMatchViewController.self, name: "RoomInside") else { return }
        navigationController?.pushViewController(peopleMatchViewController, animated: true)
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
