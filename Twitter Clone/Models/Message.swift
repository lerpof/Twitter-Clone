//
//  Message.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 10/05/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Message: Identifiable, Decodable, Hashable {
	
	@DocumentID var id: String?
	
	let body: String
	let sender: String
	let timestamp: Timestamp
	
}
