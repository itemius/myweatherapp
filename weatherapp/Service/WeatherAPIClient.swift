//
//  WeatherAPIClient.swift
//  weatherapp
//
//  Created by itemius on 25.09.2023.
//

import Foundation

class WeatherAPICLient {
    
    static func getForecast(lat: String, lon: String, cnt: Int, completion: @escaping (ForecastList) -> Void) {
        if let url = URL(string: Constants.API.openweathermapURL +
                            "forecast?lat=" + lat +
                            "&lon=" + lon +
                            "&cnt=" + cnt.description +
                            "&appid=" + Constants.API.openweathermapAPIkey +
                            "&units=metric") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                print(data)
                print(response)
                guard let forecast = try? decoder.decode(ForecastList.self, from: data) else {
                    print("parsing error")
                    return
                }
                completion(forecast)
              }
           }.resume()
        }
    }
    
    static func getForecast(city: String, cnt: Int, completion: @escaping (ForecastList) -> Void) {
        if let url = URL(string: Constants.API.openweathermapURL +
                            "forecast?q=" + city +
                            "&cnt=" + cnt.description +
                            "&appid=" + Constants.API.openweathermapAPIkey +
                            "&units=metric") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                print(data)
                print(response)
                guard let forecast = try? decoder.decode(ForecastList.self, from: data) else {
                    print("parsing error")
                    return
                }
                completion(forecast)
              }
           }.resume()
        }
    }

    
    static func getWeather(lat: String, lon: String, completion: @escaping (Weather) -> Void) {
        if let url = URL(string: Constants.API.openweathermapURL +
                            "weather?lat=" + lat +
                            "&lon=" + lon +
                            "&appid=" + Constants.API.openweathermapAPIkey +
                            "&units=metric") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                guard let weather = try? decoder.decode(Weather.self, from: data) else {
                    print("parsing error")
                    return
                }
                completion(weather)
              }
           }.resume()
        }
    }
    
    static func getWeather(city: String, completion: @escaping (Weather) -> Void) {
        if let url = URL(string: Constants.API.openweathermapURL +
                            "weather?q=" + city +
                            "&appid=" + Constants.API.openweathermapAPIkey +
                            "&units=metric") {
           URLSession.shared.dataTask(with: url) { data, response, error in
              if let data = data {
                
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .useDefaultKeys
                guard let weather = try? decoder.decode(Weather.self, from: data) else {
                    print("parsing error")
                    return
                }
                completion(weather)
              }
           }.resume()
        }
    }

    
    static func downloadWeatherIcon(icon: String, completion: @escaping (Data) -> Void) {
        downloadImage(from: URL(string: Constants.API.openweathermapIconURL + icon + "@2x.png")!, completion: {
            data in
            completion(data)
        })
    }
    
    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    static func downloadImage(from url: URL, completion: @escaping (Data) -> Void) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completion(data)
        }
    }
}
