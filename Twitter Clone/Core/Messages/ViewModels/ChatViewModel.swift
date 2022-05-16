//
//  ChatViewModel.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 10/05/22.
//

import Foundation

class ChatViewModel: ObservableObject {
	
	@Published var chat: Chat?
	@Published var messageText: String = ""
	
	let userService = UserService()
	let messageService = MessageService()
	
	init(with user: User) {
		fetchChat(with: user)
	}
	
	func fetchChat(with user: User) {
		messageService.createChat(with: user) { chat in
			self.chat = chat
			self.chat!.recipient = user
			self.messageService.addListener(to: self.chat!) { message in
				self.chat!.messages.insert(message, at: 0)
			}
		}
	}
	
	func sendMessage(with body: String, completion: @escaping (Bool) -> ()) {
		messageService.sendMessage(in: chat!, with: body) { successfullySent in
			completion(successfullySent)
		}
	}
	
}
