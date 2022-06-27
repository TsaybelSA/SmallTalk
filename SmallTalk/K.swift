//
//  Constants.swift
//  
//
//  Created by Сергей Цайбель on 27.06.2022.
//

struct K {
	static let appName = "SmallTalk 👻"
	static let cellIdentifier = "ReusableCell"
	static let cellNibName = "MessageCell"
	static let registerSegue = "RegisterToChat"
	static let loginSegue = "LoginToChat"
	
	struct BrandColors {
		static let purple = "BrandPurple"
		static let lightPurple = "BrandLightPurple"
		static let blue = "BrandBlue"
		static let lighBlue = "BrandLightBlue"
	}
	
	struct FStore {
		static let collectionName = "messages"
		static let senderField = "sender"
		static let bodyField = "body"
		static let dateField = "date"
	}
}

