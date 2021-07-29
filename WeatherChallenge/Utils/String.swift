//
//  String.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import Foundation

extension String {
    /// Method that gets if a String contains only number characters
    func onlyContainsNumbers() -> Bool {
        return CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
}
