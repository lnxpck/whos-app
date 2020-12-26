//
//  UserNetwork.swift
//  whos-app
//
//  Created by PATRICK LESAINT on 17/10/2019.
//  Copyright © 2019 PATRICK LESAINT. All rights reserved.
//

import Moya

enum UserNetwork {
    case user(page: Int)
}

extension UserNetwork: TargetType {
    
    var headers: [String : String]? {
        return ["accept": "application/json"]
    }
    
    var baseURL: URL {
        return URL(string: "https://randomuser.me")!
    }
    
    var path: String {
        switch self {
        case .user:
            return "/api"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .user:
            return .get
        }
    }
    
    var parameters: [String: Any]? {
        return [:]
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        case .user:
            return URLEncoding.default
        }
    }
    
    var sampleData: Data {
        switch self {
        case .user:
            let data = stubbedResponse("get_user")
            return data!
        }
    }
    
    var task: Task {
        switch self {
        case .user(let page):
            return .requestParameters(parameters: ["page": page, "nat": "fr", "results": "15"], encoding: URLEncoding.default)
        }
    }
    
    var validate: Bool {
        return true
    }
}

extension TargetType {
    
    func stubbedResponse(_ filename: String) -> Data! {
        let file = Bundle.main.path(forResource: filename, ofType: "json")
        return try! String(contentsOfFile: file!, encoding: String.Encoding.utf8).data(using: String.Encoding.utf8)!
    }
}
