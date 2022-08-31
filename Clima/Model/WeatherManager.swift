//
//  WeatherManager.swift
//  Clima
//
//  Created by Nikita  on 8/28/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}


struct WeatherManager{
    
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?appid=c2249643fbc743dff414b110230958ed&units=metric"
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func fetchWeather(lat: Double, lon: Double){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String){
        //1. Create a URL
        guard let url = URL(string: urlString) else { return }
        
        //2. Create a URLSession (it's the thing that can perform networking)
        let session = URLSession(configuration: .default)
        
        //3. Give URLSession a task
        let task =  session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                delegate?.didFailWithError(error: error!)
                return
            }
            
            guard let safeData = data else {return}
            guard let weather = self.parseJSON(safeData) else {return}
            self.delegate?.didUpdateWeather(self, weather: weather)
        }
        
        // 4. Start the task
        //Newly-initialized tasks begin in a suspended state, so you need to call this method to start the task.
        task.resume()
    }
    
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            let conditionID = decodedData.weather[0].id
            
            let weather = WeatherModel(conditionID: conditionID, cityName: cityName, temperature: temp)
            
            return weather
            
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
       
    }
    
    
   
    
        
    }




