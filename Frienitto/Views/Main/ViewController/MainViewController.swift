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
        navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func didTapDidTapMakeRoom(_ sender: UIButton) {
        guard let roomMakeViewController = UIStoryboard(name: "MakeRoom", bundle: nil).instantiateInitialViewController() as? MakeRoomViewController else {fatalError("MakeRoom error")}
        navigationController?.pushViewController(roomMakeViewController, animated: true)
    }
    
    @IBAction func didTapEnterRoom(_ sender: UIButton) {
        guard let roomInside = UIStoryboard(name: "RoomInside", bundle: nil).instantiateInitialViewController() as? RoomEnterViewController else {fatalError("RoomInside error")}
        navigationController?.pushViewController(roomInside, animated: true)
    }

    @IBAction func didTapLogOut(_ sender: UIButton) {
        guard let alertViewController = UIStoryboard.instantiate(TwoButtonAlertViewController.self, name: "Login") else { return }
        alertViewController.delegate = self
        alertViewController.configure(status: .logout)
        present(alertViewController, animated: true)
    }
}

extension MainViewController: TwoButtonAlertViewControllerDelegate { }
