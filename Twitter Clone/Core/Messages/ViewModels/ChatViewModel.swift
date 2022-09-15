//
//  ChatViewModel.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 10/05/22.
//

import Foundation

class ChatViewModel: ObservableObject {
	
    @Published var chat: Chat?
    
	let chatService = ChatService()
    let messageService = MessageService()
    let recipient: User
    @Published var dataFetched: Bool = false
    
    init(with recipient: User) {
        self.recipient = recipient
    }
    
    func fetchData() {
        if !dataFetched {
            chatService.fetchChat(with: recipient) { chat in
                self.chat = chat
                self.fetchMessages()
            }
            if let chat = chat, let messages = chat.messages, !messages.isEmpty {
                dataFetched = true
            }
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
        if chat != nil {
            messageService.addListener(to: self.chat!) { message in
                self.chat!.messages?.insert(message, at: 0)
            }
        }
    }

	
}
