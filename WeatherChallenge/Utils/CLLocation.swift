//
//  CLLocation.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import Foundation
import MapKit

extension CLLocation {
    /// Var  that stores latitude and longitude in a custom format
    var dms: String { latitudeFormatted + ", " + longitudeFormatted }
    
    /// Var  that shows latitude in reference of cardinal points
    var latitudeFormatted: String {
        let (degrees, minutes, seconds) = coordinate.latitude.dms
        return String(format: "%d°%d'%d\"%@", abs(degrees), minutes, seconds, degrees >= 0 ? "N" : "S")
    }
    
    /// Var  that shows longitude in reference of cardinal points
    var longitudeFormatted: String {
        let (degrees, minutes, seconds) = coordinate.longitude.dms
        return String(format: "%d°%d'%d\"%@", abs(degrees), minutes, seconds, degrees >= 0 ? "E" : "W")
    }
}
