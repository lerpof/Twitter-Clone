//
//  ChatViewModel.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 10/05/22.
//

import Foundation

class ChatViewModel: ObservableObject {
	
    @Published var messages = [Message]()
    var recipient: User
    var chat: Chat?
    
	let chatService = ChatService()
    let messageService = MessageService()
    
    init(with recipient: User) {
        self.recipient = recipient
        chatService.fetchChat(with: recipient) { chat in
            self.chat = chat
            self.fetchMessages()
        }
    }
	
    func sendMessage(with body: String, completion: @escaping (Bool) -> ()) {
        if let chat = chat {
            messageService.sendMessage(in: chat, with: body) { messageID in
                self.chatService.updateChat(chat, with: ["lastMessageID": messageID])
                completion(true)
            }
        }
	}
    
    func fetchMessages() {
        if let chat = chat {
            messageService.addListener(to: chat) { message in
                self.messages.insert(message, at: 0)
            }
        }
    }

	
}
