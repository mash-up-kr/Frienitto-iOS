//
//  FrienttoProvider.swift
//  Frienitto
//
//  Created by Gaon Kim on 29/06/2019.
//  Copyright © 2019 Mash-Up. All rights reserved.
//

import Foundation
import Moya
import Result

class FrienttoProvider {
    let provider = MoyaProvider<FrienttoService>()
    
    func signUp(username: String,
                description: String,
                imageCode: Int,
                email: String,
                password: String,
                completion: @escaping ((Response?) -> Void),
                failure: @escaping ((Error) -> Void)) {
        provider.request(.signUp(username: username, description: description, imageCode: imageCode, email: email, password: password)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func signIn(email: String,
                password: String,
                completion: @escaping ((Response?) -> Void),
                failure: @escaping ((Error) -> Void)) {
        provider.request(.signIn(email: email, password: password)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func createRoom(title: String,
                    password: String,
                    daysAfterEnum: DaysButtonEnum,
                    completion: @escaping ((Response?) -> Void),
                    failure: @escaping ((Error) -> Void)) {
        provider.request(.createRoom(title: title, code: password, daysAfterEnum: daysAfterEnum)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
        
    }
    
    func joinRoom(title: String,
                  code: String,
                  completion: @escaping ((Response?) -> Void),
                  failure: @escaping ((Error) -> Void)) {
        provider.request(.joinRoom(title: title, code: code)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func retrieveRoomList(completion: @escaping ((Response?) -> Void),
                          failure: @escaping ((Error) -> Void)) {
        provider.request(.retrieveRoomList) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func retrieveRoomDetail(id: Int,
                            completion: @escaping ((Response?) -> Void),
                            failure: @escaping ((Error) -> Void)) {
        provider.request(.retrieveRoomDetail(id: id)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func matchingStart(roomId: Int,
                       participantId: [Int],
                       completion: @escaping ((Response?) -> Void),
                       failure: @escaping ((Error) -> Void)) {
        provider.request(.matchingStart(roomId: roomId, participantId: participantId)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
    
    func issueCode(receiverInfo: String,
                   type: String,
                   completion: @escaping ((Response?) -> Void),
                   failure: @escaping ((Error) -> Void)) {
        provider.request(.issueCode(receiverInfo: receiverInfo, type: type)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }

    func authCode(receiverInfo: String,
                  type: String,
                  code: String,
                  completion: @escaping ((Response?) -> Void),
                  failure: @escaping ((Error) -> Void)) {
        provider.request(.authCode(receiverInfo: receiverInfo, type: type, code: code)) { result in
            self.resultTask(result, completion: completion, failure: failure)
        }
    }
}

extension FrienttoProvider {
    func resultTask(_ result: Result<Response, MoyaError>,
                    completion: @escaping ((Response?) -> Void),
                    failure: @escaping ((Error) -> Void)) {
        switch result {
        case .success(let response):
            let statusCode = response.statusCode
            if statusCode >= 300 {
                failure(MoyaError.statusCode(response))
            } else {
                completion(response)
            }
        case .failure(let error):
            failure(error)
        }
    }
}
