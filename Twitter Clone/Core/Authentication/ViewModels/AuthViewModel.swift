//
//  AuthViewModel.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 27/04/22.
//

import SwiftUI
import Firebase

class AuthViewModel: ObservableObject {
	
	@Published var userSession: FirebaseAuth.User?
	@Published var currentUser: User?
	
	private let service = UserService()
	
	init() {
		self.userSession = Auth.auth().currentUser
		self.fetchUser()
	}
	
	func login(withEmail email: String, password: String) {
		Auth.auth().signIn(withEmail: email, password: password) { result, error in
			if let error = error {
				print("DEBUG: Failed to register with error \(error.localizedDescription)")
				return
			}
			guard let user = result?.user else {
				return
			}
			self.userSession = user
			self.fetchUser()
		}
	}
	
	func register(withEmail email: String, password: String, fullname: String, username: String, image: UIImage) {
		Auth.auth().createUser(withEmail: email, password: password) { result, error in
			if let error = error {
				print("DEBUG: Failed to register with error \(error.localizedDescription)")
				return
			}
			guard let user = result?.user else {
				return
			}
			
			ImageUploader.uploadImage(image: image) { profileImageURL in
				let data: [String: Any] = ["email" : email,
										   "username" : username.lowercased(),
										   "fullname" : fullname,
										   "profileImageURL" : profileImageURL,
										   "likes" : [String]() ]
				Firestore.firestore().collection("users")
					.document(user.uid)
					.setData(data) { _ in
						self.userSession = user
						self.fetchUser()
					}
			}
			
		}
		
	}
	
	func logOut() {
		userSession = nil
		currentUser = nil
		do {
			try Auth.auth().signOut()
		} catch {
			print(error.localizedDescription)
		}
	}
	
	func fetchUser() {
		guard let uid = self.userSession?.uid else { return }
		service.fetchUser(withUid: uid) { user in
			self.currentUser = user
		}
	}
	
}
