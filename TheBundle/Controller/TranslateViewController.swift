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
        frenchTextField.resignFirstResponder()
        searchTranslate()
    }
    
    // MARK: - Methodes
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowTocityLabel()
    }
    
    private func addShadowTocityLabel() {
        translateButton.layer.shadowColor = UIColor.black.cgColor
        translateButton.layer.shadowOpacity = 0.9
    }
    
    func searchTranslate() {
        guard let frenchText = frenchTextField.text else { return }
        toggleActivityIndicator(shown: true)
        
        TranslateService.shared.getTranslation(frenchText: frenchText) { (succes,settings, translationResult) in
            self.toggleActivityIndicator(shown: false)
            guard let result = translationResult, succes == true else {
              //  self.presentAlert()
                return
            }
            self.updateTranslate (translationResult: result)
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        translateButton.isHidden = shown
        translateActivityIndicator.isHidden = !shown
    }
    
    private func updateTranslate (translationResult: TranslationResult) {
        englishtextLabel.text = translationResult.data.translations[0].translatedText
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
