//
//  Forecast.swift
//  weatherapp
//
//  Created by itemius on 26.09.2023.
//

import Foundation

struct Forecast: Decodable {
    let dt: Double
    let main: Temperature
}

struct Temperature: Decodable {
    let temp: Double
}

struct ForecastList: Decodable {
    let list: [Forecast]
}
