//
//  MessagesViewModel.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 10/05/22.
//

import Firebase

class MessagesViewModel: ObservableObject {
	
	@Published var chats: [Chat] = []
	
	private let messageService = MessageService()
	private let userService = UserService()
	
	init() {
		messageService.addListenerToChats { chatAdded in
			self.fetchLastMessageAndRecipient(to: chatAdded) { chat in
				self.chats.append(chat)
			}
		} updateCompletion: { chatUpdated in
			if let indexOfChat = self.chats.firstIndex(where: { $0.id == chatUpdated.id }) {
				self.fetchLastMessageAndRecipient(to: self.chats[indexOfChat]) { chat in
					self.chats[indexOfChat] = chat
				}
			}
		}
	}
	
	private func fetchLastMessageAndRecipient(to chat: Chat, completion: @escaping (Chat) -> ()) {
		if let uid = Auth.auth().currentUser?.uid,
		   let recipientID = chat.participants.first(where: { $0 != uid }) {
			self.userService.fetchUser(withUid: recipientID) { recipient in
				var chatWithRecipient = chat
				chatWithRecipient.recipient = recipient
				self.messageService.fetchMessage(from: chat, with: chat.lastMessageID) { message in
					chatWithRecipient.lastMessage = message
					completion(chatWithRecipient)
				}
			}
		}
	}
	
	
}
