//
//  TrackResponse.swift
//  Twist
//

import Foundation

struct TrackResponse: Decodable {
    let name: String
    let artist: ArtistResponse
}

struct ArtistResponse: Decodable {
    let name: String
}
