//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
    }
    
    
    var weatherManager = WeatherManager()

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

