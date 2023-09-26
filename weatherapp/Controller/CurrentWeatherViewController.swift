//
//  ViewController.swift
//  weatherapp
//
//  Created by itemius on 25.09.2023.
//

import UIKit
import CoreLocation

class CurrentWeatherViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    var latitude = ""
    var longitude = ""
    var city = ""
    
    @IBOutlet weak var weatherMainLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherMainLabel.text = ""
        weatherDescriptionLabel.text = ""
        temperatureLabel.text = ""

        locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let authorizationStatus = locationManager.authorizationStatus

        if (authorizationStatus == .authorizedWhenInUse) {
            
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
        locationManager.startUpdatingLocation()

    }
}

extension CurrentWeatherViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
                        
            latitude = location.coordinate.latitude.description
            longitude = location.coordinate.longitude.description
            
            let alert = UIAlertController(title: nil, message: "Loading...", preferredStyle: .alert)

            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = .medium
            loadingIndicator.startAnimating();

            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)
            
            WeatherAPICLient.getWeather(lat: latitude, lon: longitude, completion: {
                weather in
                DispatchQueue.main.async() { [weak self] in
                    self?.weatherDescriptionLabel.text = weather.description
                    self?.temperatureLabel.text = "Temperature: " + weather.temperature.description + " °C"
                    self?.weatherMainLabel.text = weather.main
                    self?.cityLabel.text = "Weather in " + (weather.city != "" ? weather.city : "your location")
                }
                WeatherAPICLient.downloadWeatherIcon(icon: weather.icon, completion: {
                    data in
                    DispatchQueue.main.async() { [weak self] in
                        self?.weatherImageView.image = UIImage(data: data)
                        self?.dismiss(animated: false, completion: nil)
                    }
                })
            })
            
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let alert = UIAlertController(title: nil, message: "Location update failed...", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
