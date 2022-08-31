//
//  WeatherModel.swift
//  Clima
//
//  Created by Nikita  on 8/31/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherModel{
    let conditionID: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String{
        let temp = round(temperature * 10) / 10.0
        return String(temp)
    }
    
    var conditionName: String {
        switch conditionID{
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.heavyrain"
        case 600...622:
            return "cloud.snow"
        case 701...741:
            return "smoke"
        case 751...781:
            return "tornado"
        case 800:
            return "sun.min"
        case 801...804:
            return "cloud"
        default:
            return "cloud"
        }
    }
    
       
 }
