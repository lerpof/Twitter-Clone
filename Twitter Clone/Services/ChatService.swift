//
//  ChatService.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/05/22.
//

import Firebase
import FirebaseFirestoreSwift

class ChatService {
    
    private var chatsCollectionRef = Firestore.firestore().collection("chats")
    
    func fetchChats(completion: @escaping ([Chat]) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        chatsCollectionRef.whereField("participants", arrayContains: uid).getDocuments { snapshot, error in
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
    
    func fetchChat(with recipient: User, completion: @escaping (Chat) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        chatsCollectionRef
            .whereField("participants", arrayContains: uid)
            .getDocuments(completion: { snapshot, error in
                if let documents = snapshot?.documents {
                    for document in documents {
                        let chat = try! document.data(as: Chat.self)
                        if chat.participants.contains(recipient.id!) {
                            completion(chat)
                            return
                        }
                    }
                    self.createChat(with: recipient, completion: completion)
                }
                
            })
    }
    
    func createChat(with recipient: User, completion: @escaping (Chat) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let participants = [uid, recipient.id!]
        let data: [String: Any] = ["participants": participants,
                                   "lastMessageID": ""]
        let docRef = self.chatsCollectionRef.document()
        docRef.setData(data)
        let chat = Chat(id: docRef.documentID,
                        participants: participants,
                        lastMessageID: "")
        completion(chat)
    }
    
    func updateChat(_ chat: Chat, with data: [String: Any]) {
        chatsCollectionRef.document(chat.id!)
            .updateData(data)
    }
    
    func addListenerToChats(addCompletion: @escaping (Chat) -> (),
                            updateCompletion: @escaping (Chat) -> ()) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        chatsCollectionRef.whereField("participants", arrayContains: uid)
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

extension ChatService {
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
}
