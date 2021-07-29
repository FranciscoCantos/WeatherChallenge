//
//  WeatherView.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import Foundation
import UIKit
import CoreLocation

protocol WeatherViewProtocol {
    func configureView()
    func getPlaceWeather(_ location: CLLocation)
    func setViewModel(_ weatherModel: WeatherViewModel)
}

class WeatherView: UIView, ChangeableColorProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var iconView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var maxMinLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Methods
    func configureView() {
        self.isHidden = true
        tempLabel.isHidden = true
        maxMinLabel.isHidden = true
        descriptionLabel.isHidden = true
        iconView.isHidden = true
        
        backgroundColor = UIColor.white.withAlphaComponent(0.5)
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        tempLabel.textColor = .white
        maxMinLabel.textColor = .white
        descriptionLabel.textColor = .white
    }
    
    func setViewModel(_ weatherModel: WeatherViewModel){
        self.isHidden = false
        tempLabel.isHidden = false
        maxMinLabel.isHidden = false
        descriptionLabel.isHidden = false
        iconView.isHidden = false
        
        tempLabel.text = "\(weatherModel.temp)ºC, feels: \(weatherModel.feelsTemps)ºC"
        maxMinLabel.text = "Min: \(weatherModel.minTemp)ºC / Max: \(weatherModel.maxTemp)ºC"
        descriptionLabel.text = weatherModel.weatherDescription?.capitalized
        iconView.setNetworkImage(urlString: weatherModel.iconURL ?? "")
    }
    
    func setWhiteContent() {
        tempLabel.textColor = .white
        maxMinLabel.textColor = .white
        descriptionLabel.textColor = .white
    }
    
    func setBlackContent() {
        tempLabel.textColor = .black
        maxMinLabel.textColor = .black
        descriptionLabel.textColor = .black
    }
}
