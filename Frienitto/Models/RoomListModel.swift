//
//  RoomListModel.swift
//  Frienitto
//
//  Created by Gaon Kim on 2019/08/11.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation

struct RoomListModel: Codable {
    let code: Int
    let data: [Room]
    let msg: String
}
