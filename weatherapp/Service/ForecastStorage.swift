//
//  ForecastStorage.swift
//  weatherapp
//
//  Created by itemius on 26.09.2023.
//

import Foundation
import CoreData

class ForecastStorage {
    
    var forecastList = [Forecast]()
    
    func storeForecastList(_ list: [Forecast]) {
        
    }
    
    func getForecastList() -> [Forecast] {
        return forecastList
    }
}
