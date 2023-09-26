//
//  ForecastViewController.swift
//  weatherapp
//
//  Created by itemius on 25.09.2023.
//

import UIKit
import CoreLocation

class ForecastViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var titleLable: UILabel!
    
    var forecastList = [Forecast]()

    let locationManager = CLLocationManager()
    var city = ""
    var latitude = ""
    var longitude = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        forecastTableView.dataSource = self
        forecastTableView.delegate = self
        
        locationManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let userDefaults = UserDefaults.standard
        if let selectedCity = userDefaults.string(forKey: "city") {
            city = selectedCity
            titleLable.text = "Forecast in \(city)"
            
            WeatherAPICLient.getForecast(city: city, cnt: 30, completion: {
                forecastList in
                
                self.forecastList = forecastList.list
                DispatchQueue.main.async() { [weak self] in
                    
                    self?.forecastTableView.reloadData()
                }
            })
        } else {
            locationManager.startUpdatingLocation()
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let forecast = forecastList[indexPath.row]
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        let dateString = dateFormatter.string(from: Date(timeIntervalSince1970: forecast.dt))

        cell.textLabel?.text = "\(dateString) temperature \(forecast.main.temp) °C"
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ForecastViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
                        
            latitude = location.coordinate.latitude.description
            longitude = location.coordinate.longitude.description
            
            WeatherAPICLient.getForecast(lat: latitude, lon: longitude, cnt: 30, completion: {
                forecastList in
                
                self.forecastList = forecastList.list
                DispatchQueue.main.async() { [weak self] in
                    
                    self?.forecastTableView.reloadData()
                }
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
