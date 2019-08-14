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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addLottieView()
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
}
