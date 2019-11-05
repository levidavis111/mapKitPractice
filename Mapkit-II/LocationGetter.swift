//
//  LocationGetter.swift
//  Mapkit-II
//
//  Created by Levi Davis on 11/5/19.
//  Copyright © 2019 Levi Davis. All rights reserved.
//

import Foundation
import CoreLocation

struct GetLocation {
    static func getData(name: String, type: String) -> Data {
        guard let path = Bundle.main.path(forResource: name, ofType: type) else {fatalError()}
        let internalURL = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: internalURL)
            return data
        } catch {
            fatalError()
        }
    }
}
