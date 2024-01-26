//
//  WeatherViewController.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 02/01/2024.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherTemperature: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var weatherButton: UIButton!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cityNameLabelB: UILabel!
    @IBOutlet weak var weatherTemperatureB: UILabel!
    @IBOutlet weak var weatherDescriptionB: UILabel!
    
    // var weatherService = WeatherService(weatherSession: URLSession, weatherSessionB: URLSession)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowTocityLabel()
    }
    
    private func addShadowTocityLabel() {
        weatherTemperature.layer.shadowColor = UIColor.black.cgColor
        weatherTemperature.layer.shadowOpacity = 0.9
        weatherTemperature.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    
    @IBAction func tappedWeatherButton(_ sender: Any) {
        searchWeather()
    }
    
    func searchWeather() {
        toggleActivityIndicator(shown: true)
        
        WeatherService.shared.getWeather { (succes,settings, weatherResult) in
            self.toggleActivityIndicator(shown: false)
            guard let weatherResult = weatherResult, succes == true else {
                self.presentAlert()
                return
            }
            self.updateWeather(weatherResult: weatherResult)
        }
        
        
        let seconds = 0.8
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            
            WeatherService.shared.getWeatherB { (succes,settings, weatherResultB) in
                self.toggleActivityIndicator(shown: false)
                guard let weatherResultB = weatherResultB, succes == true else {
                    self.presentAlertB()
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
        weatherTemperature.text = String(weatherResult.main.temp)
        weatherDescription.text = weatherResult.weather[0].description
        
        
    }
    
    private func updateWeatherB(weatherResultB: WeatherResultB) {
        cityNameLabelB.text = weatherResultB.name
        weatherTemperatureB.text = String(weatherResultB.main.temp)
        weatherDescriptionB.text = weatherResultB.weather[0].description
    }
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "weather download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    private func presentAlertB() {
        let alertVC = UIAlertController(title: "Error", message: "weather download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}
