//
//  JoinRoomModel.swift
//  Frienitto
//
//  Created by Gaon Kim on 12/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct JoinRoomModel: Codable {
    struct Data: Codable {
        let id: Int
        let title: String
        let status: String
        let expiresDate: String
        let isOwner: Bool
        let participants: [User]
        
        enum CodingKeys: String, CodingKey {
            case id, title, status, participants
            case expiresDate = "expires_date"
            case isOwner = "is_owner"
        }
    }
    
    let code: Int
    let msg: String
    let data: Data
}
