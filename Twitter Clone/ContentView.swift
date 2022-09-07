//
//  ContentView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/04/22.
//

import SwiftUI

struct ContentView: View {
	// usable in whole environment
	@EnvironmentObject var viewModel: AuthViewModel
	
    var body: some View {
		Group {
            if viewModel.userSession == nil {
				NavigationView {
					LoginView()
				}
			} else {
				MainTabView()
                    .environmentObject(viewModel)
			}
		}
    }
}

