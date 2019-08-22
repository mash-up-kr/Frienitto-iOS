//
//  MatchingStartModel.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/15.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct MatchingStartModel: Codable {
    let code: Int
    let data: Data
    let msg: String
    
    struct Data: Codable {
        let roomId: Int
        let roomStatus: String
        let missions: [Mission]
        
        enum CodingKeys: String, CodingKey {
            case roomId = "room_id"
            case roomStatus = "room_status"
            case missions
        }
    }
}
