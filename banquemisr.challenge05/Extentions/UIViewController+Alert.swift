//
//  UIViewController+Alert.swift
//  banquemisr.challenge05
//
//  Created by mac on 31/08/2024.
//

import UIKit

extension UIViewController {
    func ShowAlertMessage(message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        // Present the alert controller on the provided view controller
        self.present(alertController, animated: true, completion: nil)
    }
}
