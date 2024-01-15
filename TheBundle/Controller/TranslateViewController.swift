//
//  TranslateViewController.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 02/01/2024.
//

import UIKit

class TranslateViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var frenchTextField: UITextField!
    @IBOutlet weak var englishtextLabel: UILabel!
    @IBOutlet weak var translateActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var translateButton: UIButton!
    
    
    
    // MARK: - Actions
    
    @IBAction func tappedTranslateButton(_ sender: Any) {
        searchTranslate()
    }
    
    func searchTranslate() {
        
        guard let frenchText = frenchTextField.text else { return }
        
        toggleActivityIndicator(shown: true)
        
        TranslateService.shared.getTranslate(frenchText: frenchText) { succes, translations in
            self.toggleActivityIndicator(shown: false)
            guard let translations = translations, succes == true else {
                self.presentAlert()
                return
            }
            self.updateTranslate(translations: translations)
        }
    }
    
    // MARK: - Methodes
    
    private func toggleActivityIndicator(shown: Bool) {
        translateButton.isHidden = shown
        translateActivityIndicator.isHidden = !shown
    }
    
    private func updateTranslate (translations: Translations) {
        englishtextLabel.text = translations.data.translations[0].translatedText
    }
    
    private func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message: "weather download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
// MARK: - Extentions

extension TranslateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ frenchTextField: UITextField) -> Bool {
        frenchTextField.resignFirstResponder()
        searchTranslate()
        return true
    }
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        frenchTextField.resignFirstResponder()
    }
}
