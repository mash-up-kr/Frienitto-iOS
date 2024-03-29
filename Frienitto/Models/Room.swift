//
//  Room.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/11.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct Room: Codable {
    let expiresDate: String
    let id: Int
    let isOwner: Bool?
    let status: String
    let title: String
    let participants: [User]?
    
    enum CodingKeys: String, CodingKey {
        case expiresDate = "expires_date"
        case isOwner = "is_owner"
        case id, status, title, participants
    }
}
