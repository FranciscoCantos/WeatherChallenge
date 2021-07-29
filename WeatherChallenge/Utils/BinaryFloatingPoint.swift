//
//  BinaryFloatingPoint.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import Foundation

extension BinaryFloatingPoint {
    /// Var  that shows a Binary Floating Point in degrees, seconds and minutes.
    var dms: (degrees: Int, minutes: Int, seconds: Int) {
        var seconds = Int(self * 3600)
        let degrees = seconds / 3600
        seconds = abs(seconds % 3600)
        return (degrees, seconds / 60, seconds % 60)
    }
}
