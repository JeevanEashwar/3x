//
//  LoginSignUpViewController.swift
//  3x
//
//  Created by Jeevan Eashwar on 07/06/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class LoginSignUpViewController: BaseViewController {
    var typeOfControllerAction: ControllerActionType = .Login {
        didSet {
            configureUI(type: typeOfControllerAction)
        }
    }
    @IBOutlet weak var screenTypeIndicatorLabel: UILabel!
    @IBOutlet weak var emailInput: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordInput: SkyFloatingLabelTextField!
    @IBOutlet weak var loginSignUpButton: UIButton!
    @IBOutlet weak var switchSignUpLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        typeOfControllerAction = .Login
    }
    @IBAction func switchBetweenLoginAndSignUp(_ sender: Any) {
        toggleControllerAction()
    }
    @IBAction func loginSignUpClicked(_ sender: Any) {
        guard let emailText = emailInput.text, let passwordText = passwordInput.text, !emailText.isEmpty, !passwordText.isEmpty else {
            return
        }
        switch typeOfControllerAction {
        case .Login:
            FirebaseManager.authenticateUser(email: emailText, password: passwordText) { (result, error) in
                if let error = error {
                    self.presentInfoAlert(title: ErrorTitles.loginFailed, message: error.localizedDescription, completion: nil)
                }
                else if let result = result {
                    self.presentInfoAlert(title: "Success", message: "user for \(result.user.email) logged in successfully.") {
                        
                    }
                }
            }
        case .SignUp:
            FirebaseManager.signUpUser(email: emailText, password: passwordText) { (result, error) in
                if let error = error {
                    self.presentInfoAlert(title: ErrorTitles.signUpFailed, message: error.localizedDescription, completion: nil)
                }
                else if let result = result {
                    self.presentInfoAlert(title: "Success", message: "user for \(result.user.email) created successfully. Please login.") {
                        self.typeOfControllerAction = .Login
                        DispatchQueue.main.async {
                            self.passwordInput.text = ""
                        }
                    }
                }
            }
        }
    }
    func toggleControllerAction() {
        switch typeOfControllerAction {
        case .Login:
            typeOfControllerAction = .SignUp
        case .SignUp:
            typeOfControllerAction = .Login
        }
    }
    func configureUI(type: ControllerActionType) {
        DispatchQueue.main.async {
            switch type {
            case .Login:
                self.screenTypeIndicatorLabel.text = Constants.LoginSignUp.loginUpperCase
                self.loginSignUpButton.setTitle(Constants.LoginSignUp.loginCamelCase, for: .normal)
                self.switchSignUpLoginButton.setTitle(Constants.LoginSignUp.switchToSignUp, for: .normal)
            case .SignUp:
                self.screenTypeIndicatorLabel.text = Constants.LoginSignUp.signUpUpperCase
                self.loginSignUpButton.setTitle(Constants.LoginSignUp.signUpCamelCase, for: .normal)
                self.switchSignUpLoginButton.setTitle(Constants.LoginSignUp.switchToLogin, for: .normal)
            }
        }
    }
}

enum ControllerActionType {
    case Login
    case SignUp
}
