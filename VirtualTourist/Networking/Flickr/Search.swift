//
//  Search.swift
//  VirtualTourist
//
//  Created by Joel Stevick on 5/18/22.
//

import Foundation
import CoreLocation

func search(coordinate: CLLocationCoordinate2D) async {
    let session = URLSession.shared
    
    var request = URLRequest(url: URL(string: FlickrConfig.makeSearchUrl(coordinate: coordinate))!)
    request.httpMethod = "GET"
    
    do {
        let (data, _) =  try await session.data(for: request as URLRequest)
        let result = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        
        let decoder = JSONDecoder()
        
        let response = try decoder.decode(SearchResponse.self, from: data)
        
        var photoUrls = [String]()
        
        for photo in response.photos.photo {
            photoUrls.append(FlickrConfig.makePhotoUrl(photo))
        }
        
        print(photoUrls)
    } catch {
        print("Error Searching Flickr", error)
    }
    
}
