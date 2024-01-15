//
//  WeatherViewController.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 02/01/2024.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weatherTemperature: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var nowButton: UIButton!
    @IBOutlet weak var weatherActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowTocityLabel()
    }
    
    private func addShadowTocityLabel() {
        cityName.layer.shadowColor = UIColor.black.cgColor
        cityName.layer.shadowOpacity = 0.9
        cityName.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
    
    
    @IBAction func tappedNowButton(_ sender: Any) {
        toggleActivityIndicator(shown: true)
        
        WeatherService.shared.getweather { succes, weather in
            self.toggleActivityIndicator(shown: false)
            guard let weather = weather, succes == true else {
                self.presentAlert()
                return
            }
            self.updateWeather(weather: weather)
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        nowButton.isHidden = shown
        weatherActivityIndicator.isHidden = !shown
    }
    
    
    private func updateWeather(weather: Weather) {
        cityName.text = weather.name
        weatherTemperature.text = String(weather.main.temp)
        weatherDescription.text = weather.weather.description
    }
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "weather download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
  
    
}
