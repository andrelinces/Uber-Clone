//
//  Passenger.swift
//  Uber Clone
//
//  Created by Andre Linces on 04/11/21.
//

import UIKit
import MapKit

class Passenger: Codable {
    internal init(email: String, longitude: CLLocationDegrees, latitude: CLLocationDegrees, nome: String, distancePassenger: Double) {
        self.email = email
        self.longitude = longitude
        self.latitude = latitude
        self.nome = nome
        self.distancePassenger = distancePassenger
    }
    
    
    var email : String
    var longitude : CLLocationDegrees
    var latitude : CLLocationDegrees
    var nome : String
    var distancePassenger : Double
}
