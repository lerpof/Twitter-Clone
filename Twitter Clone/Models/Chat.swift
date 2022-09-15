//
//  Chat.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 10/05/22.
//

import FirebaseFirestoreSwift
import Firebase

struct Chat: Identifiable, Decodable {
	
	@DocumentID var id: String?
	
	let participants: [String]
    let messageIDs: [String]
	let lastMessageID: String
	
	var lastMessage: Message?
	var recipient: User?
    var messages: [Message]?
	
}
