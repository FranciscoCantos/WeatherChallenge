//
//  CLPlacemark.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import MapKit

extension CLPlacemark {
    /// Method that gets the formatted description of a CLPlacemark
    func getDescription() -> String {
        var nameString = ""
        if let name = name, !name.isEmpty, !name.onlyContainsNumbers() {
            nameString.append(name)
        }
        
        if let locality = locality, !locality.isEmpty {
            if !nameString.isEmpty {
                nameString.append(", ")
            }
            nameString.append(locality)
        }
        
        var locationString = ""
        if let location = location?.dms, !location.isEmpty {
            locationString = location
        }
        
        var countryString = ""
        if let country = country {
            countryString = country
        }
        
        return """
        \(nameString).
        \(countryString)
        
        \(locationString)
        """
    }
}
