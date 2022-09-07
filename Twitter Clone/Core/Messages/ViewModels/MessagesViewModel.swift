//
//  MessagesViewModel.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 10/05/22.
//

import Firebase

class MessagesViewModel: ObservableObject {
	
	@Published var chats: [Chat] = []
    
    @Published var searchBarText = ""
    var searchableChat: [Chat] {
        var unfilteredChats = [Chat]()
        if searchBarText.isEmpty {
            unfilteredChats = chats
        } else {
            let lowercasedQuery = searchBarText.lowercased()
            
            unfilteredChats = chats.filter { chat in
                if let recipient = chat.recipient {
                    return recipient.username.contains(lowercasedQuery) ||
                    recipient.fullname.lowercased().contains(lowercasedQuery)
                } else {
                    return false
                }
            }
        }
        return unfilteredChats.filter { chat in
            return chat.lastMessageID != ""
        }
    }
    
    @Published var selectedUser: User? = nil
	
	private let chatService = ChatService()
    private let messageService = MessageService()
	private let userService = UserService()
	
	init() {
        chatService.addListenerToChats(addCompletion: { chatAdded in
			self.fetchLastMessageAndRecipient(to: chatAdded) { chat in
				self.chats.append(chat)
			}
		},
        updateCompletion: { chatUpdated in
			if let indexOfChat = self.chats.firstIndex(where: { $0.id == chatUpdated.id }) {
				self.fetchLastMessageAndRecipient(to: chatUpdated) { chat in
					self.chats[indexOfChat] = chat
				}
			}
		})
	}
	
	private func fetchLastMessageAndRecipient(to chat: Chat, completion: @escaping (Chat) -> ()) {
		if let uid = Auth.auth().currentUser?.uid,
		   let recipientID = chat.participants.first(where: { $0 != uid }) {
			self.userService.fetchUser(withUid: recipientID) { recipient in
				var chatWithRecipient = chat
				chatWithRecipient.recipient = recipient
                if !chat.lastMessageID.isEmpty {
                    self.messageService.fetchMessage(in: chat, with: chat.lastMessageID) { message in
                        chatWithRecipient.lastMessage = message
                        completion(chatWithRecipient)
                    }
                } else {
                    completion(chatWithRecipient)
                }
			}
		}
	}
	
	
}
