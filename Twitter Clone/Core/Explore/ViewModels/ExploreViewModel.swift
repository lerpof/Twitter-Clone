//
//  ExploreViewModel.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 29/04/22.
//

import Foundation

class ExploreViewModel: ObservableObject {
	
	@Published var users = [User]()
	@Published var searchText = ""
    @Published var selectedUser: User? = nil
	
	var searchableUsers: [User] {
		if searchText.isEmpty {
			return users
		} else {
			let lowercasedQuery = searchText.lowercased()
			
			return users.filter { user in
				user.username.contains(lowercasedQuery) ||
				user.fullname.lowercased().contains(lowercasedQuery)
			}
		}
	}
	
	let service = UserService()
	
	init() {
		fetchUsers()
	}
	
	func fetchUsers() {
		service.fetchUsers { users in
			self.users = users
		}
	}
	
}
