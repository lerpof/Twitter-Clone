//
//  MessageService.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 10/05/22.
//

import Firebase
import FirebaseFirestoreSwift

class MessageService {
	
	var collectionRef = Firestore.firestore().collection("chat")
	
	private var messageListener: ListenerRegistration?
	private var chatListener: ListenerRegistration?
	
	func fetchChats(completion: @escaping ([Chat]) -> ()) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		collectionRef.whereField("participants", arrayContains: uid).getDocuments { snapshot, error in
			guard let documents = snapshot?.documents else {
				print("Error fetch chats: \(error?.localizedDescription ?? "No error")")
				return
			}
			var chats: [Chat] = []
			for document in documents {
				let chat = try! document.data(as: Chat.self)
				chats.append(chat)
			}
			completion(chats)
		}
	}
	
	func fetchMessage(from chat: Chat, with id: String, completion: @escaping (Message) -> ()) {
		collectionRef.document(chat.id!).collection("messages")
			.document(id).getDocument { document, error in
				if let document = document, document.exists {
					let message = try! document.data(as: Message.self)
					completion(message)
				}
			}
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
					let participants = [uid, recipient.id!]
					let data: [String: Any] = ["participants": participants,
											   "lastMessageID": ""]
					let docRef = self.collectionRef.document()
					docRef.setData(data)
					docRef.collection("messages")
					let chat = Chat(id: docRef.documentID, participants: participants, lastMessageID: "", messages: [])
					completion(chat)
				}
				
			})
	}
	
	
	
	func sendMessage(in chat: Chat, with body: String, completion: @escaping (Bool) -> ()) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		let data: [String: Any] = ["body": body,
								   "sender": uid,
								   "recipient": chat.recipient!.id!,
								   "timestamp": Timestamp(date: Date())]
		
		var docRef: DocumentReference?
		docRef = collectionRef.document(chat.id!).collection("messages")
			.addDocument(data: data) { error in
				if let error = error {
					print("DEBUG: error adding message: \(error.localizedDescription)")
					return
				}
				self.collectionRef.document(chat.id!)
					.updateData(["lastMessageID": docRef!.documentID]) { error in
						if let error = error {
							print("DEBUG: error adding message \(error.localizedDescription)")
							completion(false)
							return
						}
						completion(true)
					}
		}
		
	}
	
	func addListener(to chat: Chat,
					 addCompletion: @escaping (Message) -> (Void)) {
		messageListener = collectionRef.document(chat.id!).collection("messages").addSnapshotListener({ snapshot, error in
			guard let snapshot = snapshot else {
				print("Error listening messages for update: \(error?.localizedDescription ?? "No error")")
				return
			}
			snapshot.documentChanges.forEach { change in
				self.handleDocumentChange(change, addCompletion: addCompletion)
			}
		})
	}
	
	func addListenerToChats(addCompletion: @escaping (Chat) -> (),
							updateCompletion: @escaping (Chat) -> ()) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		chatListener = collectionRef.whereField("participants", arrayContains: uid)
			.addSnapshotListener({ snapshot, error in
			guard let snapshot = snapshot else {
				print("Error listening chats for update: \(error?.localizedDescription ?? "No error")")
				return
			}
			snapshot.documentChanges.forEach { change in
				self.handleChatChange(change,
									  addCompletion,
									  updateCompletion)
			}
		})
	}
	
}

// MARK: - Extension for helper functions
extension MessageService {
	
	private func handleChatChange(_ change: DocumentChange,
								  _ addCompletion: @escaping (Chat) -> (),
								  _ updateCompletion: @escaping (Chat) -> ()) {
		guard let chat = try? change.document.data(as: Chat.self) else {
			return
		}
		switch change.type {
		case .added:
			addCompletion(chat)
		case .modified:
			updateCompletion(chat)
		default:
			break
		}
	}
	
	/// Function that handle the change on document calling the right  completion.
	/// - Parameters:
	///   - change: change that affect the document
	///   - addCompletion: completion for add changing on document
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
