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
    @IBOutlet weak var converterActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var converterButton: UIButton!
    

    // MARK: - ACTIONS
    
    @IBAction func tappedConverterButton(_ sender: Any) {
        toggleActivityIndicator (shown: true)
        
        ConverterService.shared.getCurrency { succes, currency in
            self.toggleActivityIndicator(shown: false)
            guard let currency = currency, succes == true else {
                self.presentAlert()
                return
            }
            self.update(currency:currency)
        }
        
    }
    
    // MARK: - methode
    private func toggleActivityIndicator(shown: Bool) {
        converterButton.isHidden = shown
        converterActivityIndicator.isHidden = !shown
    }
    
    
    func update(currency: Currency) {
        currencyBLabel.text = currency.ratesUsd
    
    }
    
    func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "The currency download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
    
    
    
    
}







