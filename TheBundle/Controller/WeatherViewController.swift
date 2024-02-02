//
//  WeatherViewController.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 02/01/2024.
//

import UIKit

class WeatherViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherTemperature: UILabel!
    @IBOutlet weak var degreeLabel: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityNameLabelB: UILabel!
    @IBOutlet weak var weatherTemperatureB: UILabel!
    @IBOutlet weak var degreeBLabel: UILabel!
    @IBOutlet weak var weatherDescriptionB: UILabel!
    
    // MARK: - Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        searchWeather()
        addShadowTocityLabel(weatherTemperature: weatherTemperature, degreeLabel: degreeLabel, weatherTemperatureB: weatherTemperatureB, degreeBLabel: degreeBLabel)
    }
    
    func searchWeather() {
        WeatherService.shared.getWeather { (succes, settingsWeather, weatherResult) in
            guard let weatherResult = weatherResult, succes == true else {
                self.presentAlertWeather(error: settingsWeather ?? SettingsWeather.errorData)
                return
            }
            self.updateWeather(weatherResult: weatherResult, cityNameLabel: self.cityNameLabel, weatherTemperature: self.weatherTemperature, weatherDescription: self.weatherDescription)
        }
        let seconds = 0.8
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            
            WeatherService.shared.getWeatherB { (succes,settingsWeather, weatherResultB) in
                guard let weatherResultB = weatherResultB, succes == true else {
                    self.presentAlertWeather(error: settingsWeather ?? SettingsWeather.errorData)
                    return
                }
                self.updateWeatherB(weatherResultB: weatherResultB, cityNameLabelB: self.cityNameLabelB, weatherTemperatureB: self.weatherTemperatureB, weatherDescriptionB: self.weatherDescriptionB)
            }
        }
    }
    
}
