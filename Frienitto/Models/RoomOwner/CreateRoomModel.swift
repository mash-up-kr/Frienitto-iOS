//
//  CreateRoomModel.swift
//  Frienitto
//
//  Created by Hyeontae on 11/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct CreateRoomModel: Codable {
    let code: Int
    let msg: String
    let data: Data
    
    struct Data: Codable {
        let id: Int
        let title: String
        let expiresDate: String
        let status: String
        let isOwner: Bool?
        let participants: [User]?
        
        enum CodingKeys: String, CodingKey {
            case id, title, status, participants
            case expiresDate = "expires_date"
            case isOwner = "is_owner"
        }
    }
}
