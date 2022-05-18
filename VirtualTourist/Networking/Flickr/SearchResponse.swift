//
//  SearchResponse.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/18/22.
//

import Foundation

struct Media: Decodable {
    let m: String
}
struct Entry: Decodable {
    let title: String
    let media: Media
}
struct SearchResponse: Decodable {
    let items: [Entry]
}
