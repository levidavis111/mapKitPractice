//
//  LibraryModel.swift
//  Mapkit-II
//
//  Created by Levi Davis on 11/5/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

struct Libraries: Codable {
    let locations: [Library]
}

struct Library: Codable {
    let data: LibraryWrapper
}

class LibraryWrapper: NSObject, Codable, MKAnnotation {
    let title: String?
    let address: String
    private let position: String
    
    @objc var coordinate: CLLocationCoordinate2D {
        let latLong = position.components(separatedBy: ",").map{ $0.trimmingCharacters(in: .whitespacesAndNewlines) }.map{ Double($0) }
        guard latLong.count == 2,
        let lat = latLong[0],
            let long = latLong[1] else {return CLLocationCoordinate2D.init()}
        
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    var hasValidCoordinates: Bool {
        return coordinate.latitude != 0 && coordinate.longitude != 0
    }
    
    static func getLibraries(from jsonData: Data) -> [LibraryWrapper] {
        do {
            let response = try JSONDecoder().decode(Libraries.self, from: jsonData)
            
            return response.locations.map{ $0.data }
        } catch {
            print(error)
            return []
        }
    }
}

