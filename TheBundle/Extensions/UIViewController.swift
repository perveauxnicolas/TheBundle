//
//  UIViewController.swift
//  TheBundle
//
//  Created by Perveaux Nicolas on 26/01/2024.
//

import UIKit

extension UIViewController {
    
    func presentAlert() {
        let alertVC = UIAlertController(title: "Error", message:"The currency download failed.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
  
    /*    func presentAlert(error: ConvertionService.Settings) {
     let alertVC = UIAlertController(title: "Error", message: error.rawValue, preferredStyle: .alert)
     alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
     self.present(alertVC, animated: true, completion: nil)
     }*/
    
    
}
