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
    @IBOutlet weak var activityIndicatorTranslate: UIActivityIndicatorView!
    @IBOutlet weak var translateButton: UIButton!
    
    // MARK: - Actions
    @IBAction func tappedTranslateButton(_ sender: Any) {
        frenchTextField.resignFirstResponder()
        searchTranslate()
    }
    
    // MARK: - Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToTranslateButton(translateButton: translateButton)
    }
    
    func searchTranslate() {
        guard let frenchText = frenchTextField.text else { return }
        toggleActivityIndicatorTranslate(shown: true, translateButton: translateButton, activityIndicatorTranslate: activityIndicatorTranslate)
        
        TranslateService.shared.getTranslation(frenchText: frenchText) { (succes, settingsTranslation, translationResult) in
            self.toggleActivityIndicatorTranslate(shown: false, translateButton: self.translateButton, activityIndicatorTranslate: self.activityIndicatorTranslate)
            guard let result = translationResult, succes == true else {
                self.presentAlertTranslate(error: settingsTranslation ?? SettingsTranslation.errorData)
                return
            }
            self.updateTranslate (translationResult: result, englishtextLabel: self.englishtextLabel)
        }
    }
    
}

// MARK: - Keyboard
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
