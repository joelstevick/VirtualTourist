//
//  Config.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/18/22.
//

import Foundation
import CoreLocation

struct FlickrConfig {
    private static let apiKey = "4d149edffc818464bc15fe986ba85446"
    private static let secret = "39c51aeceb0be12a"
    private static let endpoint = "https://api.flickr.com/services/rest"
    private static let service = "flickr.photos.search"
    
    static func makeSearchUrl(coordinate: CLLocationCoordinate2D) -> String {
        return "\(endpoint)/?api_key=\(apiKey)&method=\(service)&safe_search=1&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&nojsoncallback=1&format=json"
    }
    
    static func makePhotoUrl(photo: Photo) -> String {
        return "https://farm\(photo.farm).api.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
    }
}
