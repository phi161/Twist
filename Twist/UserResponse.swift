//
//  UserResponse.swift
//  Twist
//

import Foundation

struct UserResponse: Decodable {
    let name: String
    let realName: String

    enum CodingKeys: String, CodingKey {
        case name
        case realName = "realname"
    }
}
