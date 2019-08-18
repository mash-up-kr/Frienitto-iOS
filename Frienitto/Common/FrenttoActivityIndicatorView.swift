//
//  FrenttoActivityIndicatorView.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/18.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit
import Lottie

class FrenttoActivityIndicatorView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FrenttoActivityIndicatorView {
    private func commonInit() {
        addBackgroundView()
        addLoadingView()
        isUserInteractionEnabled = false
    }
    
    private func addLoadingView() {
        let view = AnimationView(name: "loading")
        view.frame.size.width = 150
        view.frame.size.height = 150
        view.center = center
        view.loopMode = .loop
        view.play()
        
        addSubview(view)
    }
    
    private func addBackgroundView() {
        let view = UIView(frame: frame)
        view.backgroundColor = .black
        view.layer.opacity = 0.6
        
        addSubview(view)
    }
}
