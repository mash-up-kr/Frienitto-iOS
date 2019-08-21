//
//  MainRoomCell.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/11.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import UIKit

protocol MainRoomCellDelegate: AnyObject {
    func mainRoomCell(_ cell: MainRoomCell, enteringRoomId id: Int, status: MainRoomCell.Status)
}

class MainRoomCell: UICollectionViewCell {
    enum Status: String {
        case created = "CREATED"
        case matched = "MATCHED"
        case expired = "EXPIRED"
    }
    
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var roomDescriptionLabel: UILabel!
    @IBOutlet private weak var roomStatusLabel: UILabel!
    @IBOutlet private weak var roomImageView: UIImageView!
    @IBOutlet private weak var crownImageView: UIImageView!
    
    weak var delegate: MainRoomCellDelegate?
    private var room: Room? {
        didSet {
            if let room = room {
                crownImageView.isHidden = !room.isOwner
                status = Status(rawValue: room.status) ?? .created
            }
        }
    }
    
    private var status: Status = .created {
        didSet {
            switch status {
            case .created:
                roomStatusLabel.text = "마니또 모집중이에요"
            case .matched:
                roomStatusLabel.text = "마니또 매칭중이에요"
            case .expired:
                roomStatusLabel.text = "마니또가 발표되었어요"
            }
        }
    }
    
    @IBAction private func roomEnterButtonAction(_ sender: UIButton) {
        delegate?.mainRoomCell(self, enteringRoomId: room?.id ?? 0, status: status)
    }
    
    func configure(room: Room) {
        self.room = room
        titleLabel.text = room.title
        roomDescriptionLabel.text = "\(room.title)방입니다. 우리 친해져요!"
        roomImageView.image = UIImage(named: "listFace\(room.id % 6 + 1)")
        if let date = room.expiresDate.convertToDate() {
            let dDay = MainRoomCell.calculateDayOffsetFromToday(date: date)
            configureDateLabel(dDay: dDay)
        }
    }
    
    private func configureDateLabel(dDay: Int) {
        if dDay < 0 {
            dateLabel.text = "매칭 종료"
        } else if dDay == 0 {
            dateLabel.text = "D-day"
        } else {
            dateLabel.text = "D-day. \(dDay)"
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
