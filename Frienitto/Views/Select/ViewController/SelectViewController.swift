//
//  SelectViewController.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/14.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit
import Lottie

class SelectViewController: UIViewController {
    
    @IBOutlet private weak var contentView: UIView! {
        didSet {
            contentView.alpha = 0
        }
    }
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var userNameLabel: UILabel!
    @IBOutlet private weak var userDescriptionLabel: UILabel!
    
    var mission: Mission?
    
    var room: Room?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addLottieView()
        configureUI()
    }
    
    @IBAction private func confirmButtonAction(_ sender: UIButton) {
        guard
            let room = room,
            let mission = mission,
            let timerViewController = UIStoryboard
                .instantiate(TimerViewController.self, name: "RoomInside") else { return }
        
        timerViewController.mission = mission
        if let isOwner = room.isOwner {
            timerViewController.isOwner = isOwner
        }
        timerViewController.expiresDate = room.expiresDate.convertToDate() ?? Date()
        
        navigationController?.pushViewController(timerViewController, animated: true)
    }
    
    private func addLottieView() {
        let selectLottieView = AnimationView(name: "data")
        selectLottieView.frame = view.bounds
        selectLottieView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(selectLottieView)

        selectLottieView.loopMode = .playOnce
        selectLottieView.play() { _ in
            selectLottieView.removeFromSuperview()
            
            UIView.animate(withDuration: 0.3, delay: 0.3, animations: {
                self.contentView.alpha = 1
            })
        }
    }
    
    private func configureUI() {
        let myFrentto = mission?.to
        userImageView.image = UIImage(named: "face\(myFrentto?.imageCode ?? 1)")
        userNameLabel.text = myFrentto?.username
        userDescriptionLabel.text = myFrentto?.description
    }
}
