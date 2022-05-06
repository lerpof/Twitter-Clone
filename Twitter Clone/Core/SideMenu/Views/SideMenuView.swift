//
//  SideMenuView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 25/04/22.
//

import SwiftUI

struct SideMenuView: View {
	
	@EnvironmentObject var viewModel: AuthViewModel
	
	var body: some View {
		if let user = viewModel.currentUser {
			VStack(alignment: .leading) {
				UserProfileImageView(url: user.profileImageURL)
					.frame(width: 50, height: 50)
				Text(user.fullname)
					.font(.headline)
					.fontWeight(.semibold)
				Text("@\(user.username)")
					.font(.subheadline)
					.foregroundColor(.primary.opacity(0.5))
				ProfileFollowView()
					.padding(.vertical)
				ForEach(SideMenuViewModel.allCases, id: \.rawValue) { sideMenuOption in
					if sideMenuOption == .profile {
						NavigationLink {
							ProfileView(user: user)
								.navigationBarHidden(true)
						} label: {
							SideMenuRowView(viewModel: sideMenuOption)
						}
					} else if sideMenuOption == .logout {
						Button {
							viewModel.logOut()
						} label: {
							SideMenuRowView(viewModel: sideMenuOption)
						}
					} else {
						SideMenuRowView(viewModel: sideMenuOption)
					}
					
				}
				Spacer()
			}
			.padding()
			.background(
				Color.primary
					.opacity(0.04)
					.ignoresSafeArea(.container, edges: .vertical)
			)
		}
	}
}

struct SideMenuView_Previews: PreviewProvider {
	static var previews: some View {
		SideMenuView()
	}
}
