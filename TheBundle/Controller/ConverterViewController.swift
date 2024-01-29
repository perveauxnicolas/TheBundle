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
    @IBOutlet weak var ActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var converterButton: UIButton!
    
    var convertionService = ConvertionService(convertionSession: URLSession(configuration: .default))
    
    // MARK: - ACTIONS
    @IBAction func tappedConverterButton(_ sender: Any) {
        searchConvertion()
    }
    
    // MARK: - METHODES
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowTocityLabel()
    }
    
    private func addShadowTocityLabel() {
        converterButton.layer.shadowColor = UIColor.brown.cgColor
        converterButton.layer.shadowOpacity = 0.9
    }
    
    func searchConvertion() {
        guard let currencyA = Double(currencyATextField.text!) else { return }
        toggleActivityIndicator(shown: true)
        
        ConvertionService.shared.getConvertion(currencyA: currencyA) { (succes,settings, convertionResult) in
            self.toggleActivityIndicator(shown: false)
            guard let result = convertionResult, succes == true else {
                
                self.presentAlert()
        //   self.presentAlert(error: ConvertionService.Settings?(rawValue: String))
                
                return
            }
            self.updateConvertion (convertionResult: result)
            guard let rateUsd = convertionResult?.rates.USD else { return }
            let currencyB = currencyA * rateUsd
            self.currencyBLabel.text = "\(String(format: "%.2f",currencyB)) $"
        }
        //  dismissKeyboard(_ sender: UITapGestureRecognizer)
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        converterButton.isHidden = shown
        ActivityIndicator.isHidden = !shown
    }
    
    private func updateConvertion(convertionResult : ConvertionResult) {
        rateLabel.text = String(convertionResult.rates.USD)
    }
    /*
     func presentAlert() {
     let alertVC = UIAlertController(title: "Error", message:"The currency download failed.", preferredStyle: .alert)
     alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
     present(alertVC, animated: true, completion: nil)
     }
     */
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
