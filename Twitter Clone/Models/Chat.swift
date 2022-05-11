//
//  Chat.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 10/05/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Chat: Identifiable, Decodable {
	
	@DocumentID var id: String?
	
	let participants: [String]
	
	var recipient: User?
	var messages: [Message]! = []
	
}
