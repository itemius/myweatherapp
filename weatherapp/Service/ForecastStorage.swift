//
//  ForecastStorage.swift
//  weatherapp
//
//  Created by itemius on 26.09.2023.
//

import Foundation
import UIKit
import CoreData

class ForecastStorage {
    
    var forecastList = [Forecast]()
    
    var forecastCachedList = [NSManagedObject]()

    
    func storeForecastList(_ list: [Forecast]) {
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        
        let managedContext =
        appDelegate.persistentContainer.viewContext
        
        let entity =
          NSEntityDescription.entity(forEntityName: "Forecasts",
                                     in: managedContext)!
        
        
        for f in list {
            let forecast = NSManagedObject(entity: entity,
                                         insertInto: managedContext)
            forecast.setValue(f.dt, forKeyPath: "date")
            forecast.setValue(f.main.temp, forKeyPath: "temperature")
            do {
              try managedContext.save()
            } catch let error as NSError {
              print("Could not save. \(error), \(error.userInfo)")
            }
        }

    }
    
    func storeForecast(date: Double, temperature: Double) {

    }
    
    func getForecastList() -> [Forecast] {
        
        guard let appDelegate =
          UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        
        let managedContext =
          appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
          NSFetchRequest<NSManagedObject>(entityName: "Forecasts")
        
        do {
          forecastCachedList = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
          print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for forecast in forecastCachedList {
            let newForecast = Forecast(dt: forecast.value(forKeyPath: "date") as? Double ?? 0, main: Temperature(temp: forecast.value(forKeyPath: "temperature") as? Double ?? 0))
            
            forecastList.append(newForecast)
        }
        
        return forecastList
    }
}
