//
//  MainViewController.swift
//  WeatherChallenge
//
//  Created by Francisco Cantos
//

import UIKit
import Foundation
import CoreLocation
import Alamofire

class MainViewController: UIViewController {
    @IBOutlet weak var mapView: MapView!
    @IBOutlet weak var weatherView: WeatherView!
    @IBOutlet weak var locationView: LocationView!
    
    init() {
        super.init(nibName: "MainViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        loadRandomPlaceWeather()
    }
    
    func configureViews() {
        mapView.configureView()
        weatherView.configureView()
        locationView.configureView()
    }
    
    /// Gets a new random location, get the wheater of this new location and shows it
    private func loadRandomPlaceWeather() {
        let location = getLocation()
        mapView.setMapRegion(location)
        mapView.addAnnotation(location)
        getLocationReverseInfo(location)
        getPlaceWeather(location)
    }

    /// Shows error view with message. User can cancel or retry get a new location
    /// - Parameter errorMessage: Error to show
    func showError(_ errorMessage: String?) {
        let alertController = UIAlertController(title: "App Error",
                                                message: errorMessage ?? "Unknown error description",
                                                preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "Dismiss",
                                                style: .default))
        alertController.addAction(UIAlertAction(title: "Retry",
                                                style: .default,
                                                handler: { action -> Void in
                                                    self.loadRandomPlaceWeather()
                                                }))
        self.present(alertController, animated: true, completion: nil)
    }
            
    @IBAction private func reloadCoordinates(_ sender: Any) {
        loadRandomPlaceWeather()
    }
    
    @IBAction private func satelliteSwitchChanged(_ sender: Any) {
        mapView.changeMapType()
        if mapView.mapType == .satellite {
            setWhiteContent()
        } else {
            setBlackContent()
        }
    }
    
    /// Gets from API the weather of a location. Also displays in the weather view. Shows error alert view if something fails
    /// - Parameter location: The location to get the weather
    func getPlaceWeather(_ location: CLLocation) {
        let longitudeString = "\(location.coordinate.longitude)"
        let latitudeString = "\(location.coordinate.latitude)"
        _ = try? AF.request(EndpointsConfiguration.getWeather(latitude: latitudeString,
                                                              longitude: longitudeString).asURLRequest())
            .validate()
            .responseDecodable { (response: DataResponse<WeatherResponse,AFError>) in
                switch response.result {
                case .success:
                    _ = response.result.map {
                        self.showWeatherView(WeatherViewModel(apiResponse: $0))
                    }
                case let .failure(error):
                    if error.responseCode != 404 {
                        self.showError(error.errorDescription)
                    }
                }
            }
    }
    
    /// Shows the weather info retrieved
    /// - Parameter model: The view model with the info retrieved
    func showWeatherView(_ model: WeatherViewModel) {
        weatherView.setViewModel(model)
    }
        
    /// Gets random latitude and longitude and checks if are valid.
    /// - Returns: Random valid location
    func getLocation() -> CLLocation {
        var randomLatitude, randomLongitude: Double
        repeat {
            randomLatitude = Double.random(in: -90..<90).rounded(toPlaces: 4)
            randomLongitude = Double.random(in: -180..<180).rounded(toPlaces: 4)
        } while CLLocationCoordinate2DIsValid(CLLocationCoordinate2DMake(randomLatitude, randomLongitude)) == false
        
        return CLLocation(latitude: randomLatitude, longitude: randomLongitude)
    }
        
    /// Get info of the given location using CLGeocoder
    /// - Parameter location: The location to get info.
    func getLocationReverseInfo(_ location: CLLocation) {
        CLGeocoder().reverseGeocodeLocation(location) { (places, error) in
            self.manageRetrievedLocation(places, error)
        }
    }
    
    /// Manages the retrieved info to show it on the view
    /// - Parameters:
    ///   - places: Retrieved places
    ///   - error: Error given if any
    private func manageRetrievedLocation(_ places: [CLPlacemark]?, _ error: Error?) {
        if (error != nil) {
            showError(error?.localizedDescription)
        } else {
            guard let place = places?.first else {
                showError("Cant find correct place")
                return
            }
            if let _ = place.ocean {
                loadRandomPlaceWeather()
            }
            else {
                locationView.setLocationDescription(place.getDescription())
            }
        }
    }
    
    /// Sets black color to the view items to improve the displayed info
    func setBlackContent() {
        mapView.setBlackContent()
        weatherView.setBlackContent()
        locationView.setBlackContent()
    }
    
    /// Sets white color to the view items to improve the displayed info
    func setWhiteContent() {
        mapView.setWhiteContent()
        weatherView.setWhiteContent()
        locationView.setWhiteContent()
    }
}
