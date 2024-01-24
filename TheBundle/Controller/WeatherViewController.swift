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
    @IBOutlet weak var nowButton: UIButton!
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    
      override func viewDidLoad() {
     super.viewDidLoad()
     addShadowTocityLabel()
     }
     
     private func addShadowTocityLabel() {
         weatherTemperature.layer.shadowColor = UIColor.black.cgColor
         weatherTemperature.layer.shadowOpacity = 0.9
         weatherTemperature.layer.shadowOffset = CGSize(width: 1, height: 1)
     }
    /*  */
    
    @IBAction func tappedNowButton(_ sender: Any) {
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
            self.updateWeather (weatherResult: weatherResult)
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        nowButton.isHidden = shown
        ActivityIndicator.isHidden = !shown
    }
    
    private func updateWeather(weatherResult: WeatherResult) {
        cityNameLabel.text = weatherResult.name
        weatherTemperature.text = String(weatherResult.main.temp)
        weatherDescription.text = weatherResult.weather[2].description
        
        
    }
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "weather download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
}
