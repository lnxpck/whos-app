//
//  Users.swift
//  whos-app
//
//  Created by PATRICK LESAINT on 16/10/2019.
//  Copyright © 2019 PATRICK LESAINT. All rights reserved.
//

import Foundation

public struct Users: Decodable {
    let results: [User]?
    let info: Info?
    
    private enum CodingKeys: String, CodingKey {
        case results, info
    }
}

struct Info: Decodable {
    let seed: String?
    let results: Int?
    let page: Int?
    let version: String?
}

struct User: Decodable {
    let gender: Gender?
    let name: Name?
    let location: Location?
    let email: String?
    let login: Login?
    let dob, registered: Dob?
    let phone, cell: String?
    let picture: Picture?
    let nat: String?
}

struct Dob: Decodable {
    let date: String?
    let age: Int?
}

enum Gender: String, Codable {
    case female
    case male
}

struct Location: Decodable {
    let street: Street?
    let city, state, country: String?
    let coordinates: Coordinates
    let postcode: Int?
}

struct Coordinates: Decodable {
    let latitude: String?
    let longitude: String?
}

struct Street: Decodable {
    let number: Int?
    let name: String?
}

struct Login: Decodable {
    let uuid, username, password, salt: String?
    let md5, sha1, sha256: String?
}

struct Name: Decodable {
    let title: String?
    let first, last: String?
}

struct Picture: Decodable {
    let large, medium, thumbnail: String?
}
