//
//  Track.swift
//  Twist
//

import Foundation

struct Track {
    let name: String
    let artist: String
}

extension Track: CustomDebugStringConvertible {
    var debugDescription: String {
        return "🎵\(artist)-\(name)"
    }
}
