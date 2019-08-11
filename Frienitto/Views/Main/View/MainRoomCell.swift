//
//  MainRoomCell.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/11.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

protocol MainRoomCellDelegate: AnyObject {
    func mainRoomCell(_ cell: MainRoomCell, enteringRoomId id: Int)
}

class MainRoomCell: UICollectionViewCell {
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var roomDescriptionLabel: UILabel!
    @IBOutlet private weak var roomStatusLabel: UILabel!
    @IBOutlet private weak var roomImageView: UIImageView!
    
    weak var delegate: MainRoomCellDelegate?
    private var room: Room!
    
    @IBAction private func roomEnterButtonAction(_ sender: Any) {
        delegate?.mainRoomCell(self, enteringRoomId: room.id)
    }
    
    func configure(room: Room) {
        self.room = room
        titleLabel.text = room.title
        roomDescriptionLabel.text = "\(room.title)방입니다. 우리 친해져요!"
        roomImageView.image = UIImage(named: "listFace\(room.id % 6 + 1)")
        if let date = room.expiresDate.convertToDate() {
            dateLabel.text = "D-Day. \(MainRoomCell.calculateDayOffsetFromToday(date: date))"
        }
    }
    
    private static func getTodayWithoutTime() -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let dateString = formatter.string(from: Date())
        return formatter.date(from: dateString) ?? Date()
    }
    
    private static func calculateDayOffsetFromToday(date: Date) -> Int {
        let offsetComponent = Calendar(identifier: .gregorian).dateComponents([.day], from: getTodayWithoutTime(), to: date)
        guard let dayOffset = offsetComponent.day else { return 0 }
        return dayOffset
    }
}
