//
//  RegisterViewController.swift
//  SmallTalk
//
//  Created by Сергей Цайбель on 24.06.2022.
//

import UIKit
import FirebaseAuth

class RegisterViewController: UIViewController {
	
	@IBOutlet var emailTextField: UITextField!
	@IBOutlet var passwordTextField: UITextField!
	@IBOutlet var registerButton: UIButton!
	
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
	
	@IBAction func registerButtonPressed(_ sender: UIButton) {
		guard let email = emailTextField.text, let password = passwordTextField.text else { return }
		guard isEmailValid(email) && isPasswordValid(password) else { return }
		Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
				if let error = error {
					self.handleAuthError(error as NSError)
				} else {
					self.performSegue(withIdentifier: K.registerSegue, sender: self)
				}
		}
	}
}

extension String {  // удаление списка charecters  из строки
	func removeCharacters(from forbiddenChars: CharacterSet) -> String {
		let passed = self.unicodeScalars.filter {!forbiddenChars.contains($0)}
		return String(String.UnicodeScalarView(passed))
	}

	func removeCharacters(from: String) -> String {
		return removeCharacters(from: CharacterSet(charactersIn: from))
	}
}


extension RegisterViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == emailTextField {
			passwordTextField.becomeFirstResponder()
		} else {
			//here need to use the same function that in button action
//			registerButtonPressed(UIButton.init())
		}
		return true
	}
	
	
}
