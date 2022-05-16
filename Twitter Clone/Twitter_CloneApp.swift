//
//  Twitter_CloneApp.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/04/22.
//

import SwiftUI
import Firebase

@main
struct Twitter_CloneApp: App {
	
	@StateObject var viewModel = AuthViewModel()
	
	init() {
		FirebaseApp.configure()
	}
	
    var body: some Scene {
        WindowGroup {
			ContentView()
				.environmentObject(viewModel)
        }
    }
}
