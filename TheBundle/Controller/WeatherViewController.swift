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
    @IBOutlet weak var weatherButton: UIButton!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityNameLabelB: UILabel!
    @IBOutlet weak var weatherTemperatureB: UILabel!
    @IBOutlet weak var degreeBLabel: UILabel!
    @IBOutlet weak var weatherDescriptionB: UILabel!
    
    
    // MARK: - Actions
    @IBAction func tappedWeatherButton(_ sender: Any) {
        searchWeather()
    }
    
    // MARK: - Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        searchWeather()
        addShadowTocityLabel()
    }
    
    private func addShadowTocityLabel() {
        weatherTemperature.layer.shadowColor = UIColor.blue.cgColor
        weatherTemperature.layer.shadowOpacity = 0.9
        degreeLabel.layer.shadowColor = UIColor.blue.cgColor
        degreeLabel.layer.shadowOpacity = 0.9
        weatherTemperatureB.layer.shadowColor = UIColor.blue.cgColor
        weatherTemperatureB.layer.shadowOpacity = 0.9
        degreeBLabel.layer.shadowColor = UIColor.blue.cgColor
        degreeBLabel.layer.shadowOpacity = 0.9
        weatherButton.layer.shadowColor = UIColor.black.cgColor
        weatherButton.layer.shadowOpacity = 0.9
    }
    
    func searchWeather() {
        toggleActivityIndicator(shown: true)
        
        WeatherService.shared.getWeather { (succes,settings, weatherResult) in
            self.toggleActivityIndicator(shown: false)
            guard let weatherResult = weatherResult, succes == true else {
        //        self.presentAlert()
                return
            }
            self.updateWeather(weatherResult: weatherResult)
        }
        
        let seconds = 0.8
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            
            WeatherService.shared.getWeatherB { (succes,settings, weatherResultB) in
                self.toggleActivityIndicator(shown: false)
                guard let weatherResultB = weatherResultB, succes == true else {
         //           self.presentAlert()
                    return
                }
                self.updateWeatherB(weatherResultB: weatherResultB)
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        weatherButton.isHidden = shown
        ActivityIndicator.isHidden = !shown
    }
    
    private func updateWeather(weatherResult: WeatherResult) {
        cityNameLabel.text = weatherResult.name
        weatherTemperature.text = String(format: "%.0f", weatherResult.main.temp)
        weatherDescription.text = weatherResult.weather[0].description
    }
    
    private func updateWeatherB(weatherResultB: WeatherResultB) {
        cityNameLabelB.text = weatherResultB.name
        weatherTemperatureB.text = String(format: "%.0f", weatherResultB.main.temp)
        weatherDescriptionB.text = weatherResultB.weather[0].description
    }
    
}
