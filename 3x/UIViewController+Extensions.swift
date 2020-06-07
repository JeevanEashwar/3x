//
//  UIViewController+Extensions.swift
//  3x
//
//  Created by Jeevan Eashwar on 07/06/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import UIKit

public enum AlertActionButtonType {
    case primaryButton, secondaryButton
}

extension UIViewController {
    func presentInfoAlert(title: String, message: String, completion: (() -> Void)?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in

        }
        alert.addAction(OKAction)
        self.present(alert, animated: true, completion: completion)
    }
}

