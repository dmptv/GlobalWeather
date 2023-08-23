//
//  AlertRoutableProtocol.swift
//  GlobalWeather
//
//  Created by Kanat on 20.08.2023.
//

import UIKit

protocol AlertRoutableProtocol: PresentableProtocol {
    func showAlert(title: String, message: String)
}

extension AlertRoutableProtocol {
    public func showAlert(title: String, message: String) {
        guard let source = toPresent() else {
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.view.accessibilityIdentifier = "alert-controller_alert_view"
        let completeAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(completeAction)
        source.present(alertController, animated: true, completion: nil)
    }
}
