//
//  MessageService.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 10/05/22.
//

import Firebase

class MessageService {
	
	var collectionRef = Firestore.firestore().collection("chat")
	
	private var messageListener: ListenerRegistration?
	
	func fetchChats(completion: @escaping ([Chat]) -> ()) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		collectionRef.whereField("participants", arrayContains: uid).getDocuments { snapshot, error in
			guard let documents = snapshot?.documents else {
				print("Error fetch chats: \(error?.localizedDescription ?? "No error")")
				return
			}
			var chats: [Chat] = []
			for document in documents {
				var chat = try! document.data(as: Chat.self)
				self.fetchMessages(from: chat) { messages in
					chat.messages = messages
				}
				chats.append(chat)
			}
			completion(chats)
		}
	}
	
	private func fetchMessages(from chat: Chat, completion: @escaping ([Message]) -> ()) {
		collectionRef.document(chat.id!).collection("messages")
			.getDocuments(completion: { snapshot, error in
				guard let documents = snapshot?.documents else {
					print("Error fetch messages: \(error?.localizedDescription ?? "No error")")
					return
				}
				var messages: [Message] = []
				for document in documents {
					let message = try! document.data(as: Message.self)
					messages.append(message)
				}
				completion(messages)
			})
	}
	
	func createChat(with recipient: User, completion: @escaping (Chat) -> ()) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		collectionRef
			.whereField("participants", arrayContains: uid)
			.getDocuments(completion: { snapshot, error in
				if let documents = snapshot?.documents {
					for document in documents {
						var chat = try! document.data(as: Chat.self)
						if chat.participants.contains(recipient.id!) {
							chat.messages = []
							completion(chat)
							return
						}
					}
					let data: [String: [String]] = ["participants": [uid, recipient.id!]]
					let docRef = self.collectionRef.document()
					docRef.setData(data)
					docRef.collection("messages")
					let chat = Chat(id: docRef.documentID, participants: data["participants"]!, messages: [])
					completion(chat)
				}
				
			})
	}
	
	
	
	func sendMessage(in chat: Chat, with body: String) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		let data: [String: Any] = ["body": body,
								   "sender": uid,
								   "recipient": chat.recipient!.id!,
								   "timestamp": Timestamp(date: Date())]
		
		collectionRef.document(chat.id!).collection("messages").addDocument(data: data)
	}
	
	func addListener(to chat: Chat,
					 addCompletion: @escaping (Message) -> (Void)) {
		messageListener = collectionRef.document(chat.id!).collection("messages").addSnapshotListener({ snapshot, error in
			guard let snapshot = snapshot else {
				print("Error listening for update: \(error?.localizedDescription ?? "No error")")
				return
			}
			snapshot.documentChanges.forEach { change in
				self.handleDocumentChange(change, addCompletion: addCompletion)
			}
		})
	}
	
	private func handleDocumentChange(_ change: DocumentChange,
									  addCompletion: @escaping (Message) -> ()) {
		guard let message = try? change.document.data(as: Message.self) else {
			return
		}
		switch change.type {
		case .added:
			addCompletion(message)
		default:
			break
		}
	}
	
}
