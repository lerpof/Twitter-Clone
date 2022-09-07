//
//  UserService.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 29/04/22.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
	
    private let userCollectionRef = Firestore.firestore().collection("users")
    
	func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        userCollectionRef
            .document(uid)
			.getDocument { snapshot, _ in
				guard let snapshot = snapshot else { return }
				
				guard let user = try? snapshot.data(as: User.self) else { return }
				
				completion(user)
			}
	}
	
	func fetchUsers(completion: @escaping([User]) -> Void) {
        userCollectionRef
            .getDocuments { snapshot, _ in
				guard let documents = snapshot?.documents else { return }
				var users = documents.compactMap({ try? $0.data(as: User.self) })
                guard let uid = Auth.auth().currentUser?.uid else { return }
                users = users.filter { $0.id != uid }
				completion(users)
			}
	}
    
    func updateUser(userID: String, with data: [String: Any]) {
        userCollectionRef
            .document(userID)
            .updateData(data)
    }
	
}
