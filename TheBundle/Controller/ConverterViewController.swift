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
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var converterButton: UIButton!
    
    
    // MARK: - ACTIONS
    
    @IBAction func tappedConverterButton(_ sender: Any) {
        searchConvertion()
    }
    
    func searchConvertion() {
        guard let currencyA = Double(currencyATextField.text!) else { return }
        toggleActivityIndicator(shown: true)
        
        ConvertionService.shared.getConvertion(currencyA: currencyA) { (succes,settings, convertionResult) in
            self.toggleActivityIndicator(shown: false)
            guard let result = convertionResult, succes == true else {
                self.presentAlert()
                return
            }
           self.updateTranslate (convertionResult: result)
        }
    }
    
    // MARK: - methode
    private func toggleActivityIndicator(shown: Bool) {
        converterButton.isHidden = shown
        ActivityIndicator.isHidden = !shown
    }
    

    func updateTranslate(convertionResult : ConvertionResult) {
        guard let resultA =  convertionResult.rates["USD"] else { return }
        currencyBLabel.text = String(resultA)
        
    }
    
    func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The currency download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}


// MARK: - Extentions

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







