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
    @IBOutlet weak var shareButton: UIButton!
    
    // MARK: - Property
    
    var roomNameString: String = ""
    var roomPasswordString: String = ""
    var buttonSelectedEnum: DaysButtonEnum?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBasicInfo()
    }
    
    // MARK: - Method
    
    private func setBasicInfo() {
        guard let buttonSelectedEnum = buttonSelectedEnum else { return }
        roomNameField.text = roomNameString
        roomPasswordField.text = roomPasswordString
        switch buttonSelectedEnum {
        case .threeDays:
            threeDaysAfterButton.backgroundColor = UIColor(named: "darkIndigo")
            threeDaysAfterButton.setTitleColor(.white, for: .normal)
        case .sevenDays:
            sevenDaysAfterButton.backgroundColor = UIColor(named: "darkIndigo")
            sevenDaysAfterButton.setTitleColor(.white, for: .normal)
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func closeButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonAction(_ sender: UIButton) {
        let shareText = """
        나랑 마니또 할래?😘
        방 이름 : \(roomNameString)
        비밀번호 : \(roomPasswordString)
        """
        
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        self.present(activityVC, animated: true, completion: nil)
        
    }
}
