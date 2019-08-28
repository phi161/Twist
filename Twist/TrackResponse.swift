//
//  TrackResponse.swift
//  Twist
//

import Foundation

struct TrackResponse: Decodable {
    let name: String
    let artist: ArtistResponse
    
    var track: Track {
        return Track(name: name, artist: artist.name)
    }
}

struct ArtistResponse: Decodable {
    let name: String
}
