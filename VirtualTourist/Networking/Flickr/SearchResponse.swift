//
//  SearchResponse.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/18/22.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let title: String
    let farm: String
    let secret: String
    let server: String
}

struct Photos: Decodable {
    let photo: [Photo]
}
struct SearchResponse: Decodable {
    let photos: Photos
}
