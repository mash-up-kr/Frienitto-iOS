//
//  ResultViewController.swift
//  Frienitto
//
//  Created by jarvis on 12/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var additionalInfoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func tabOnBackButton(_ sender: UIButton) {
    }
    
    @IBAction func tabOnCancelButton(_ sender: UIButton) {
    }
}
