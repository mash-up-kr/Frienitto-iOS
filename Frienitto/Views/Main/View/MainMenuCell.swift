//
//  MainMenuCell.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/12.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

protocol MainMenuCellDelegate: AnyObject {
    func mainMenuCell(_ cell: MainMenuCell, tappedButton type: MainMenuCell.Button)
}

class MainMenuCell: UICollectionViewCell {
    enum Button {
        case createRoom
        case joinRoom
    }
    
    weak var delegate: MainMenuCellDelegate?
    
    @IBAction private func createRoomButtonAction(_ sender: UIButton) {
        delegate?.mainMenuCell(self, tappedButton: .createRoom)
    }
    
    @IBAction private func joinRoomButtonAction(_ sender: UIButton) {
        delegate?.mainMenuCell(self, tappedButton: .joinRoom)
    }
}
