//
//  UIViewController.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 26/01/2024.
//

import UIKit

extension UIViewController  {
    
    // MARK: - METHODS : ConvertionService
    func presentAlertConvertion(error: SettingsConvertion) {
        let alertVC = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    func toggleActivityIndicator(shown: Bool, activityIndicatorConvertion: UIActivityIndicatorView, validateConverterButton: UIButton) {
        validateConverterButton.isHidden = shown
        activityIndicatorConvertion.isHidden = !shown
    }
    func updateConvertion(convertionResult : ConvertionResult, rateLabel: UILabel) {
        rateLabel.text = String(format: "%.4f",convertionResult.rates.USD)
    }
    func addShadowToConverterButton(converterButton: UIButton) {
        converterButton.layer.shadowColor = UIColor.black.cgColor
        converterButton.layer.shadowOpacity = 0.9
    }
    
    // MARK: - METHODS : WeatherService
    func presentAlertWeather(error: SettingsWeather) {
        let alertVC = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    func updateWeather(weatherResult: WeatherResult, cityNameLabel: UILabel, weatherTemperature: UILabel, weatherDescription: UILabel) {
        cityNameLabel.text = weatherResult.name
        weatherTemperature.text = String(format: "%.0f", weatherResult.main.temp)
        weatherDescription.text = weatherResult.weather[0].description
    }
    func updateWeatherB(weatherResultB: WeatherResultB, cityNameLabelB: UILabel, weatherTemperatureB: UILabel, weatherDescriptionB: UILabel) {
        cityNameLabelB.text = weatherResultB.name
        weatherTemperatureB.text = String(format: "%.0f", weatherResultB.main.temp)
        weatherDescriptionB.text = weatherResultB.weather[0].description
    }
    func addShadowTocityLabel(weatherTemperature: UILabel, degreeLabel: UILabel, weatherTemperatureB: UILabel, degreeBLabel: UILabel) {
        weatherTemperature.layer.shadowColor = UIColor.blue.cgColor
        weatherTemperature.layer.shadowOpacity = 0.9
        degreeLabel.layer.shadowColor = UIColor.blue.cgColor
        degreeLabel.layer.shadowOpacity = 0.9
        weatherTemperatureB.layer.shadowColor = UIColor.blue.cgColor
        weatherTemperatureB.layer.shadowOpacity = 0.9
        degreeBLabel.layer.shadowColor = UIColor.blue.cgColor
        degreeBLabel.layer.shadowOpacity = 0.9
    }
    
    // MARK: - METHODS : TranslateService
    func presentAlertTranslate(error: SettingsTranslation) {
        let alertVC = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    func updateTranslate (translationResult: TranslationResult, englishtextLabel:UILabel) {
        englishtextLabel.text = translationResult.data.translations[0].translatedText
    }
    func toggleActivityIndicatorTranslate(shown: Bool, translateButton:UIButton, activityIndicatorTranslate: UIActivityIndicatorView) {
        translateButton.isHidden = shown
        activityIndicatorTranslate.isHidden = !shown
    }
    func addShadowToTranslateButton(translateButton: UIButton) {
        translateButton.layer.shadowColor = UIColor.black.cgColor
        translateButton.layer.shadowOpacity = 0.9
    }
    
}
