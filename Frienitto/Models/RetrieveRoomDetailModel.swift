//
//  RetrieveRoomDetailModel.swift
//  Frienitto
//
//  Created by Gaon Kim on 13/07/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct RetrieveRoomDetailModel: Codable {
    struct Data: Codable {
        let id: Int
        let title: String
        let status: String
        let expiresDate: String
        let participants: [User]
        
        enum CodingKeys: String, CodingKey {
            case id, title, status, participants
            case expiresDate = "expires_date"
        }
    }
    
    let code: Int
    let msg: String
    let data: Data
}
