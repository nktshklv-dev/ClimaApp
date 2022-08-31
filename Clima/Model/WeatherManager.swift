//
//  WeatherManager.swift
//  Clima
//
//  Created by Nikita  on 8/28/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation


struct WeatherManager{
    
    let weatherURL =  "https://api.openweathermap.org/data/2.5/weather?appid=c2249643fbc743dff414b110230958ed&units=metric"
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        print(urlString)
        performRequest(urlString: urlString)
    }
    
    
    func performRequest(urlString: String){
        //MARK: - 1. Create a URL
        guard let url = URL(string: urlString) else { return }
        
        //MARK: - 2. Create a URLSession (it's the thing that can perform networking)
        let session = URLSession(configuration: .default)
        
        //MARK: - 3. Give URLSession a task
        let task =  session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            
            guard let safeData = data else {return}
            self.parseJSON(weatherData: safeData)
            
        }
        
        //MARK: - 4. Start the task
        //Newly-initialized tasks begin in a suspended state, so you need to call this method to start the task.
        task.resume()
    }
    
    
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            let conditionID = decodedData.weather[0].id
            
            let weather = WeatherModel(conditionID: conditionID, cityName: cityName, temperature: temp)
            let condName = weather.conditionName
            print(condName)
            print(weather.temperatureString)
            
        } catch{
            print(error.localizedDescription)
        }
       
    }
    
    
   
    
        
    }




