//
//  MessageService.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 10/05/22.
//

import Firebase
import FirebaseFirestoreSwift

class MessageService {
	
    private var messagesCollectionRef = Firestore.firestore().collection("messages")
	
    func fetchMessage(with id: String, completion: @escaping (Message) -> ()) {
        messagesCollectionRef.document(id).getDocument { document, error in
				if let document = document, document.exists {
					let message = try! document.data(as: Message.self)
					completion(message)
				}
			}
	}
	
	func sendMessage(in chat: Chat, with body: String, completion: @escaping (String) -> ()) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		let data: [String: Any] = ["body": body,
								   "sender": uid,
								   "timestamp": Timestamp(date: Date())]
		
        let docRef = messagesCollectionRef.addDocument(data: data)
        
        completion(docRef.documentID)
	}
	
	func addListener(to chat: Chat,
					 addCompletion: @escaping (Message) -> (Void)) {
        messagesCollectionRef.addSnapshotListener { snapshot, error in
            guard let snapshot = snapshot else {
                print("Error listening chats for update: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change,
                                          addCompletion: addCompletion)
            }
        }
	}
	

	
}

// MARK: - Extension for helper functions
extension MessageService {
	
	
	
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
