//
//  UIViewController.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 26/01/2024.
//

import UIKit

extension UIViewController  {
    
    func presentAlert(error: Settings) {
        let alertVC = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func toggleActivityIndicator(shown: Bool, activityIndicator: UIActivityIndicatorView, validateConverterButton: UIButton) {
        validateConverterButton.isHidden = shown
        activityIndicator.isHidden = !shown
    }
    
    func updateConvertion(convertionResult : ConvertionResult, rateLabel: UILabel) {
        rateLabel.text = String(format: "%.4f",convertionResult.rates.USD)
    }
    
   
}
