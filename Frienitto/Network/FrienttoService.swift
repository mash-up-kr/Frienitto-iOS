//
//  FrienttoService.swift
//  Frienitto
//
//  Created by Gaon Kim on 29/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation
import Moya

enum FrienttoService {
    case signUp(username: String, description: String, imageCode: Int, email: String, password: String)
    case signIn(email: String, password: String)
    case createRoom(name: String, code: String, daysAfterEnum: DaysButtonEnum)
    case joinRoom(id: String)
    case retrieveRoomList(id: String)
    case retrieveRoomDetail(id: String)
    case matchingStart(roomId: Int, participantId: [Int])
    case issueCode(receiverInfo: String, type: String)
    case authCode(receiverInfo: String, type: String, code: String)
}

extension FrienttoService: TargetType {
    var baseURL: URL {
        return URL(string: "http://192.168.123.26:8080")!
    }
    
    var path: String {
        switch self {
        case .signUp:
            return "/api/v1/register/user"
        case .signIn:
            return "/api/v1/login"
        case .createRoom:
            return "/api/v1/register/room"
        case .joinRoom(let id):
            return "/api/v1/join/room/\(id)"
        case .retrieveRoomList:
            return "/api/v1/room/list"
        case .retrieveRoomDetail(let id):
            return "/api/v1/room/\(id)"
        case .matchingStart:
            return "/api/v1/matching"
        case .issueCode:
            return "/api/v1/issue/code"
        case .authCode:
            return "/api/v1/verify/code"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .signUp, .signIn, .createRoom, .matchingStart, .issueCode, .authCode:
            return .post
        case .joinRoom, .retrieveRoomList, .retrieveRoomDetail:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .signUp(let username, let description, let imageCode, let email, let password):
            return .requestParameters(parameters: ["username": username,
                                                   "description": description,
                                                   "image_code": imageCode,
                                                   "email": email,
                                                   "password": password],
                                      encoding: JSONEncoding.default)
        case .signIn(let email, let password):
            return .requestParameters(parameters: ["email" : email,
                                                   "password": password],
                                      encoding: JSONEncoding.default)
        case .createRoom(let name, let code, let daysAfterEnum):
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"
            
            var date: String {
                let oneDayInterval = TimeInterval(60 * 60 * 24)
                switch daysAfterEnum {
                case .threeDays:
                    return dateFormatter.string(from: Date(timeIntervalSinceNow: 3 * oneDayInterval))
                case .sevenDays:
                    return dateFormatter.string(from: Date(timeIntervalSinceNow: 7 * oneDayInterval))
                }
            }
            
            return .requestParameters(parameters: ["name": name,
                                                   "code": code,
                                                   "expires_date": date],
                                      encoding: JSONEncoding.default)
        case .joinRoom:
            return .requestPlain
        case .retrieveRoomList:
            return .requestPlain
        case .retrieveRoomDetail:
            return .requestPlain
        case .matchingStart(let roomId, let participantId):
            return .requestParameters(parameters: ["room_id": roomId,
                                                   "participant_id": participantId],
                                      encoding: JSONEncoding.default)
        case .issueCode(let receiverInfo, let type):
            return .requestParameters(parameters: ["receiver_info": receiverInfo,
                                                   "type": type],
                                      encoding: JSONEncoding.default)
        case .authCode(let receiverInfo, let type, let code):
            return .requestParameters(parameters: ["receiver_info": receiverInfo,
                                                   "type": type,
                                                   "code": code],
                                      encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        // TODO:- token 처리
        return ["Content-type": "application/json",
                "X-Register-Token": "TESTTOKEN",
                "X-Authorization": "FEAA9DC8F3A7F5DFE6DEBCD3114947D6"]
    }
}
