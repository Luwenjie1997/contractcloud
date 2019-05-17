//
//  UIViewController+Alerts.swift
//  myContract
//
//  Created by 卢文杰 on 2019/5/18.
//  Copyright © 2019 lu. All rights reserved.
//

import UIKit

extension UIViewController {
    /**
     * Shows a default alert/info message with an OK button.
     */
    func showAlertMessage(_ message: String, okButtonTitle: String = "Ok") -> Void {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
}
