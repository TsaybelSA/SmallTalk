//
//  LoginViewController.swift
//  SmallTalk
//
//  Created by Сергей Цайбель on 23.06.2022.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
	
	var feedbackGenerator = UINotificationFeedbackGenerator()
	
	@IBOutlet var emailTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet var loginButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		emailTextField.makeBorderedWithShadow()
		emailTextField.setLeftPaddingPoints(10)
		
		passwordTextField.makeBorderedWithShadow()
		passwordTextField.setLeftPaddingPoints(10)
		
		emailTextField.delegate = self
		passwordTextField.delegate = self
		
		self.setupToHideKeyboardOnTapOnView()
	}
	
	@IBAction func loginButtonPressed(_ sender: UIButton) {
		guard let email = emailTextField.text, let password = passwordTextField.text else { return }
		guard isEmailValid(email) && isPasswordValid(password) else { return }
			Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
				if let error = error {
					self.feedbackGenerator.notificationOccurred(.error)
					self.handleAuthError(error as NSError)
				} else {
					self.performSegue(withIdentifier: K.loginSegue, sender: self)
				}
			}
	}
}


extension LoginViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == emailTextField {
			passwordTextField.becomeFirstResponder()
		} else {
			//here need to use the same function that in button action
		}
		return true
	}
	
	func textFieldDidEndEditing(_ textField: UITextField) {
		feedbackGenerator.prepare()
	}
}

