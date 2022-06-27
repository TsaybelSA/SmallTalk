//
//  WelcomeViewController.swift
//  SmallTalk
//
//  Created by Сергей Цайбель on 23.06.2022.
//

import UIKit

class WelcomeViewController: UIViewController {

	@IBOutlet var titleLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		titleLabel.makeTypeEffectForTitle(K.appName)
	}
	

}

