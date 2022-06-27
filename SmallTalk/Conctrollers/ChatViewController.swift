//
//  ChatViewController.swift
//  SmallTalk
//
//  Created by Сергей Цайбель on 24.06.2022.
//

import UIKit
import FirebaseAuth

class ChatViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		title = K.appName
		navigationItem.hidesBackButton = true
	}
	
	@IBAction func logOutPressed(_ sender: UIBarButtonItem) {
		do {
			try Auth.auth().signOut()
			navigationController?.popToRootViewController(animated: true)
		} catch let signOutError as NSError {
			print("Error signing out: %@", signOutError)
		}
	}
}
