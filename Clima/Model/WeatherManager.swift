//
//  WeatherManager.swift
//  Clima
//
//  Created by Nikita  on 8/28/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager{
    let weatherURL = URL(string: "https://api.openweathermap.org/data/2.5/weather?appid=c2249643fbc743dff414b110230958ed&units=metric")
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
    }
}
