//
//  ContentView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 24/04/22.
//

import SwiftUI

struct ContentView: View {
	// usable in whole environment
	@EnvironmentObject var viewModel: AuthViewModel
	
    var body: some View {
		Group {
			if viewModel.userSession == nil{
				NavigationView {
					LoginView()
						.navigationBarHidden(true)
						.navigationBarTitle(Text("Home"))
				}
			} else {
				MainTabView()
			}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
