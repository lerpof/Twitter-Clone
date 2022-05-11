//
//  ChatViewModel.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 10/05/22.
//

import Foundation

class ChatViewModel: ObservableObject {
	
	@Published var chat: Chat?
	
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
				self.chat!.messages.append(message)
			}
		}
	}
	
	func sendMessage(with body: String) {
		messageService.sendMessage(in: chat!, with: body)
	}
	
}
