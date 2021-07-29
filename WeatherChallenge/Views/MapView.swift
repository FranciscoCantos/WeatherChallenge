//
//  MapView.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import Foundation
import UIKit
import CoreLocation
import MapKit

protocol MapViewProtocol {
    func configureView()
    func setMapRegion(_ location: CLLocation)
    func addAnnotation(_ location: CLLocation)
    func changeMapType()
}

class MapView: UIView, ChangeableColorProtocol, MapViewProtocol {
    @IBOutlet private weak var mapView: MKMapView!
    @IBOutlet private weak var satelliteModeSwitch: UISwitch!
    @IBOutlet private weak var switchLabel: UILabel!
    
    var mapType = MKMapType.satellite
    
    // MARK: - Methods
    func configureView() {
        satelliteModeSwitch.setOn(true, animated: false)
        switchLabel.textColor = .white
        
        mapView.mapType = MKMapType.satellite
        mapView.isUserInteractionEnabled = false
    }
    
    /// Configure the map view to show a  given location
    /// - Parameter location: The location to show in the center of the MapView
    func setMapRegion(_ location: CLLocation) {
        let radius = CLLocationDistance(5000)
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: radius,
                                                  longitudinalMeters: radius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    /// Shows a annotation point in the given location
    /// - Parameter location: The location where sets the annotation point
    func addAnnotation(_ location: CLLocation) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location.coordinate
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
    }
        
    func setWhiteContent() {
        switchLabel.textColor = .white
    }
    
    func setBlackContent() {
        switchLabel.textColor = .black
    }
    
    func changeMapType() {
        if satelliteModeSwitch.isOn {
            mapType = .satellite
            mapView.mapType = .satellite
        } else {
            mapType = .standard
            mapView.mapType = .standard
        }
    }
}
