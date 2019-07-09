//
//  MakeRoomFinishViewController.swift
//  Frienitto
//
//  Created by Hyeontae on 09/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

class MakeRoomFinishViewController: UIViewController {

    // MARK: - IBOutlet
    
    @IBOutlet weak var roomNameField: UITextField! {
        didSet {
            roomNameField.borderStyle = .none
        }
    }
    @IBOutlet weak var roomPasswordField: UITextField! {
        didSet {
            roomPasswordField.borderStyle = .none
        }
    }
    @IBOutlet weak var threeDaysAfterButton: UIButton!
    @IBOutlet weak var sevenDaysAfterButton: UIButton!
    @IBOutlet weak var DoneButton: UIButton! {
        didSet {
            DoneButton.addTarget(self, action: #selector(didTapDoneButton(_:)), for: .touchUpInside)
        }
    }
    
    // MARK: - Property
    
    var roomNameString: String!
    var roomPasswordString: String!
    var buttonSelectedEnum: DaysButtonEnum!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        setBasicInfo()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Method
    
    private func setNavigationItem() {
        navigationItem.setHidesBackButton(true, animated: false)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.barTintColor = view.backgroundColor
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func setBasicInfo() {
        roomNameField.text = roomNameString
        roomPasswordField.text = roomPasswordString
        switch buttonSelectedEnum! {
        case .threeDays:
            threeDaysAfterButton.backgroundColor = UIColor(named: "darkIndigo")
            threeDaysAfterButton.setTitleColor(.white, for: .normal)
        case .sevenDays:
            sevenDaysAfterButton.backgroundColor = UIColor(named: "darkIndigo")
            sevenDaysAfterButton.setTitleColor(.white, for: .normal)
        }
    }
    
    // MARK: - objc
    
    @objc func didTapDoneButton(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }

}
