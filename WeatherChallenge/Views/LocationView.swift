//
//  LocationView.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import Foundation
import UIKit

protocol LocationViewProtocol {
    func configureView()
    func setLocationDescription(_ description: String)
}

class LocationView: UIView, ChangeableColorProtocol, LocationViewProtocol {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var coordinatesLabel: UILabel!
    @IBOutlet private weak var reloadButton: UIButton!
    
    // MARK: - Methods
    func configureView() {
        self.isUserInteractionEnabled = true
        
        reloadButton.layer.cornerRadius = 5
        reloadButton.layer.borderWidth = 0.5
        reloadButton.layer.borderColor = UIColor.black.cgColor
        reloadButton.backgroundColor = .green.withAlphaComponent(0.4)
        reloadButton.setTitleColor(.white, for: .normal)
        reloadButton.isUserInteractionEnabled = true
    }
    
    func setLocationDescription(_ description: String) {
        coordinatesLabel.text = description
    }
    
    func setWhiteContent() {
        reloadButton.setTitleColor(.white, for: .normal)
        coordinatesLabel.textColor = .white
    }
    
    func setBlackContent() {
        reloadButton.setTitleColor(.black, for: .normal)
        coordinatesLabel.textColor = .black
    }
}
