//
//  MainNavigationBar.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 07/05/22.
//

import SwiftUI

struct MainNavigationBar: View {
	
	@EnvironmentObject var viewModel: AuthViewModel
	@Binding var offset: Double
	let sideMenuWidth: Double
	
    var body: some View {
		if let user = viewModel.currentUser {
			NavigationBar {
				Button {
					withAnimation(.easeInOut) {
						offset = sideMenuWidth
					}
				} label: {
					UserProfileImageView(url: user.profileImageURL)
						.frame(width: 40, height: 40)
				}
			} titleView: {
				Image("icon")
					.resizable()
					.renderingMode(.template)
					.foregroundColor(.primary)
					.frame(width: 30, height: 30)
			} trailingView: {
				Spacer()
					.frame(width: 40, height: 40)
			}
		}
    }
}

struct MainNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
		MainNavigationBar(offset: .constant(0), sideMenuWidth: 400)
    }
}
