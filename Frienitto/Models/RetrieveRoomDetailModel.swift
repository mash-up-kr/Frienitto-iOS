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
        let participant: [User]
        
        enum CodingKeys: String, CodingKey {
            case id, title, status, participant
            case expiresDate = "expires_date"
        }
    }
    
    let code: String
    let msg: String
    let data: Data
}
