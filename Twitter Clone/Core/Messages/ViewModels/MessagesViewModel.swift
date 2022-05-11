//
//  MessagesViewModel.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 10/05/22.
//

import Foundation

class MessagesViewModel: ObservableObject {
	
	@Published var chats: [Chat] = []
	
	private let messageService = MessageService()
	
	init() {
		messageService.fetchChats { chats in
			self.chats = chats
		}
	}
	
	
}
