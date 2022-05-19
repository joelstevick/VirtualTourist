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
    private static let imageEndpoint = "https://live.staticflickr.com"
    private static let search = "flickr.photos.search"
    private static let getInfo = "flickr.photos.getInfo"
    
    static func makeSearchUrl(coordinate: CLLocationCoordinate2D) -> String {
        return "\(endpoint)/?api_key=\(apiKey)&method=\(search)&safe_search=1&lat=\(coordinate.latitude)&lon=\(coordinate.longitude)&nojsoncallback=1&format=json&per_page=10"
    }
    
    static func makeFarmPhotoUrl(_ photo: Photo) -> String {
        return "https://farm\(photo.farm).api.flickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
    }
    
    static func makePhotoUrl(_ photo: Photo) -> String {
        return "\(imageEndpoint)/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
    }
    
    static func makeGetInfoUrl(_ photo: Photo) -> String {
        return "\(endpoint)/?api_key=\(apiKey)&method=\(getInfo)&secret=\(photo.secret)&photo_id=\(photo.id)&nojsoncallback=1&format=json"
    }
}
