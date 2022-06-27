//
//  UIViewExtensions.swift
//  SmallTalk
//
//  Created by Сергей Цайбель on 23.06.2022.
//

import UIKit

extension UITextField {
	func makeBorderedWithShadow() {
		self.borderStyle = .none
		self.layer.masksToBounds = false
		self.layer.cornerRadius = 10
		self.layer.backgroundColor = UIColor.white.cgColor
		self.layer.borderColor = UIColor.clear.cgColor
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 0)
		self.layer.shadowOpacity = 0.2
		self.layer.shadowRadius = 8
	}
}

extension UITextField {
	func setLeftPaddingPoints(_ amount:CGFloat){
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
		self.leftView = paddingView
		self.leftViewMode = .always
	}
	func setRightPaddingPoints(_ amount:CGFloat) {
		let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
		self.rightView = paddingView
		self.rightViewMode = .always
	}
}

extension UILabel {
	func makeTypeEffectForTitle(_ titleString: String) {
		var animationTimer = Timer()
		self.text = ""
		for (index, letter) in titleString.enumerated() {
			Timer.scheduledTimer(withTimeInterval: 0.1 * Double(index), repeats: false) { timer in
				self.text?.append(letter)
			}
		}
		//this timer will check if all chars been typed and will call repeatAnimation func
		animationTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { timer in
			if self.text == titleString {
				self.repeatAnimationAfterDelay(animationTimer, for: self, with: titleString)
			}
		}
	}

	func repeatAnimationAfterDelay(_ checkingTimer: Timer, for label: UILabel, with titleString: String) {
		checkingTimer.invalidate()
		label.text = ""
		Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { timer in
			label.makeTypeEffectForTitle(titleString)
		}
	}
}

extension UIViewController {
	//tells to UITextField to hide keyboard when tap outside textField
	func setupToHideKeyboardOnTapOnView() {
		let tap = UITapGestureRecognizer(
			target: self,
			action: #selector(UIViewController.dismissKeyboard))

		tap.cancelsTouchesInView = false
		view.addGestureRecognizer(tap)
	}

	@objc func dismissKeyboard() {
		view.endEditing(true)
	}
	
	func isEmailValid(_ email: String) -> Bool {
		guard email.count > 5 else {
			self.showAlertEmailTypeWrong()
			return false
		}
		guard email.allSatisfy({ !$0.isEmoji }) else {
			self.showAlert(with: "Email must not contain emoji!")
			return false
		}
		guard email.filter({ $0 == "@" }).count == 1 else {
			self.showAlert(with: "Email adress entered incorrectly, please check and try again!")
			return false
		}
		let indexOfAtSign = email.firstIndex(of: "@")!
		let numberOfElementsBeforeAtSign = email[..<indexOfAtSign].count
		let stringAfterAtSign = email[indexOfAtSign...]
		guard let indexOfDot = stringAfterAtSign.firstIndex(of: ".") else {
			showAlertEmailTypeWrong()
			return false
		}
		let domainNameLenght = stringAfterAtSign[..<indexOfDot].count - 1
		let countryCodeLenght = stringAfterAtSign[indexOfDot...].count - 1
		guard numberOfElementsBeforeAtSign > 0, domainNameLenght > 0, countryCodeLenght >= 2 else {
			showAlertEmailTypeWrong()
			return false
		}
		return true
	}
	
	func isPasswordValid(_ password: String) -> Bool {
		guard password.count > 5 else {
			self.showAlert(with: "Password must be at least 6 symbols.")
			return false
		}
		guard password.allSatisfy({ !$0.isEmoji }) else {
			self.showAlert(with: "Password must not contain emoji!")
			return false
		}
		return true
	}
	
	func showAlertEmailTypeWrong() {
		showAlert(with: "Email should be of type: name@domainName.countryCode ! Please check email and try again.")
	}
	
	func handleAuthError(_ error: NSError) {
		var alertTitle = ""
		var message: String?
		switch error.code {
			case 17009: alertTitle = "Wrong password or email!"
			case 17011: alertTitle = "Wrong email!"
			case 17015: alertTitle = "This account is currently in use!"
			case 17020: alertTitle = "Something went wrong while connecting with server!!"; message = "Please check internet connection and try again."
			case 17026: alertTitle = "Password it too week!"; message = "Password shoud be at least 6 symbols"
			default: alertTitle = "Something went wrong, prease try again."
		}
		showAlert(with: alertTitle, message: message)
	}
	
	func showAlert(with title: String, message: String? = nil) {
		let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let action = UIAlertAction(title: "OK", style: .default)
		ac.addAction(action)
		present(ac, animated: true)
	}
}


extension Character {
	var isEmoji: Bool {
		// Swift does not have a way to ask if a Character isEmoji
		// but it does let us check to see if our component scalars isEmoji
		// unfortunately unicode allows certain scalars (like 1)
		// to be modified by another scalar to become emoji (e.g. 1️⃣)
		// so the scalar "1" will report isEmoji = true
		// so we can't just check to see if the first scalar isEmoji
		// the quick and dirty here is to see if the scalar is at least the first true emoji we know of
		// (the start of the "miscellaneous items" section)
		// or check to see if this is a multiple scalar unicode sequence
		// (e.g. a 1 with a unicode modifier to force it to be presented as emoji 1️⃣)
		if let firstScalar = unicodeScalars.first, firstScalar.properties.isEmoji {
			return (firstScalar.value >= 0x238d || unicodeScalars.count > 1)
		} else {
			return false
		}
	}
}
