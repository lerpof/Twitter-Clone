//
//  User.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 29/04/22.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
	@DocumentID var id: String?
	let username: String
	let fullname: String
	let profileImageURL: String
	let email: String
	let likes: [String]
	
}
