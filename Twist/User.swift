//
//  User.swift
//  Twist
//

import Foundation

struct User {
    let name: String
    let realName: String
}

extension User: CustomDebugStringConvertible {
    var debugDescription: String {
        return "\(name) (aka \(realName))"
    }
}
