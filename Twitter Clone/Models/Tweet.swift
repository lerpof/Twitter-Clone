//
//  Tweet.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 02/05/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Tweet: Identifiable, Decodable {
	
	@DocumentID var id: String?
	
	let caption: String
	let likes: Int
	let timestamp: Timestamp
	let uid: String
	
	var user: User?
	
}
