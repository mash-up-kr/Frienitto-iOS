//
//  MainViewController.swift
//  Frienitto
//
//  Created by mang on 21/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func didTapDidTapMakeRoom(_ sender: UIButton) {
        guard let roomMakeViewController = UIStoryboard.instantiate(MakeRoomViewController.self, name: "MakeRoom") else { return }
        present(roomMakeViewController, animated: true, completion: nil)
    }
    
    @IBAction func didTapEnterRoom(_ sender: UIButton) {
        guard let roomEnterViewController = UIStoryboard.instantiate(RoomEnterViewController.self, name: "RoomInside") else { return }
        navigationController?.pushViewController(roomEnterViewController, animated: true)
    }

    @IBAction func didTapLogOut(_ sender: UIButton) {
        guard let alertViewController = UIStoryboard.instantiate(TwoButtonAlertViewController.self, name: "Login") else { return }
        alertViewController.delegate = self
        alertViewController.configure(status: .logout)
        present(alertViewController, animated: true)
    }
}

extension MainViewController: TwoButtonAlertViewControllerDelegate { }
