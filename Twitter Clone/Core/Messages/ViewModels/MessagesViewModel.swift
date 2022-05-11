//
//  MessagesViewModel.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 10/05/22.
//

import Firebase

class MessagesViewModel: ObservableObject {
	
	@Published var chats: [Chat] = []
	
	private let messageService = MessageService()
	private let userService = UserService()
	
	init() {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		messageService.fetchChats { chats in
			for chat in chats {
				if let recipientID = chat.participants.first(where: { $0 != uid }) {
					self.userService.fetchUser(withUid: recipientID) { recipient in
						var chatWithRecipient = chat
						chatWithRecipient.recipient = recipient
						self.chats.append(chatWithRecipient)
					}
				}
			}
		
			
		}
	}
	
	
}
