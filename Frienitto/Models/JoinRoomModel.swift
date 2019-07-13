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
        
        enum CodingKeys: String, CodingKey {
            case id, title, status
            case expiresDate = "expires_date"
        }
    }
    
    let code: Int
    let msg: String
    let data: Data
}
