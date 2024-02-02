//
//  ConverterViewController.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 02/01/2024.
//

import UIKit

class ConverterViewController: UIViewController {
    
    // MARK: - OUTLETS
    @IBOutlet weak var currencyATextField: UITextField!
    @IBOutlet weak var currencyBLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var converterButton: UIButton!
    @IBOutlet weak var activityIndicatorConvertion: UIActivityIndicatorView!
    
    // MARK: - ACTIONS
    @IBAction func tappedConverterButton(_ sender: Any) {
        currencyATextField.resignFirstResponder()
        searchConvertion()
    }
    
    // MARK: - METHODES
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToConverterButton(converterButton: converterButton)
    }
    
    func searchConvertion() {
        guard let currencyA = Double(currencyATextField.text!) else { return }
        toggleActivityIndicator(shown: true, activityIndicatorConvertion: activityIndicatorConvertion, validateConverterButton: converterButton)
        
        ConvertionService.shared.getConvertion(currencyA: currencyA) { (succes, settingsConvertion, convertionResult) in
            self.toggleActivityIndicator(shown: false, activityIndicatorConvertion: self.activityIndicatorConvertion, validateConverterButton: self.converterButton)
            guard let result = convertionResult, succes == true else {
                self.presentAlertConvertion(error: settingsConvertion ?? SettingsConvertion.errorData)
                return
            }
            self.updateConvertion (convertionResult: result, rateLabel: self.rateLabel)
            guard let rateUsd = convertionResult?.rates.USD else { return }
            let currencyB = currencyA * rateUsd
            self.currencyBLabel.text = "\(String(format: "%.2f",currencyB)) $"
        }
    }
}

// MARK: - Keyboard
extension ConverterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ currencyATextField: UITextField) -> Bool {
        currencyATextField.resignFirstResponder()
        searchConvertion()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        currencyATextField.resignFirstResponder()
    }
}
