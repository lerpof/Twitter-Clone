//
//  User.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 29/04/22.
//

import FirebaseFirestoreSwift
import Firebase

struct User: Identifiable, Decodable {
	@DocumentID var id: String?
	let username: String
	let fullname: String
    let email: String
	let profileImageURL: String
    let coverImageURL: String
    let bio: String
    let birthDate: Timestamp
    let website: String
    let location: String
	let likes: [String]
	
}
