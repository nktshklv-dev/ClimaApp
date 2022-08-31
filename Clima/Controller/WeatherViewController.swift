//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController{
    
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
    }
}

//MARK: - UITextFieldDelegate extension
extension WeatherViewController: UITextFieldDelegate{
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if searchTextField.text != ""{
            return true
        } else {
            let ac = UIAlertController(title: "You should write something inside the textfield to discover weather!", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
            return false
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let city = searchTextField.text else {return}
        weatherManager.fetchWeather(cityName: city)
        searchTextField.text = ""
    }
    
}

//MARK: - WeatherManagerDelegate extension
extension WeatherViewController: WeatherManagerDelegate{
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            print(weather.conditionName)
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
        }
    }
    
    //when we want to display some errors in UI
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
}

