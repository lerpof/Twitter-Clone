//
//  MainTabView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/04/22.
//

import SwiftUI
import Kingfisher

struct MainTabView: View {
	
	@State private var selectedIndex: MainTabViewModels = .feed
	
	private let sideMenuWidth: Double = UIScreen.main.bounds.width * 0.7
	@State private var offset: Double = 0
	
	@State var showProfileView: Bool = false
	
	@EnvironmentObject var viewModel: AuthViewModel
	
	var body: some View {
		if let user = viewModel.currentUser {
			SideBarStack(sidebarWidth: sideMenuWidth, offset: $offset) {
				SideMenuView(showProfileView: $showProfileView)
			} content: {
				NavigationView {
					Group {
						TabView(selection: $selectedIndex) {
							ForEach(MainTabViewModels.allCases, id: \.rawValue) { mainTabOption in
								mainTabOption.view
									.onTapGesture {
										self.selectedIndex = mainTabOption
									}
									.tabItem {
										Image(systemName: mainTabOption.imageName)
									}
									.tag(mainTabOption)
							}
						}
						NavigationLink(isActive: $showProfileView) {
							ProfileView(user: user)
								.environmentObject(viewModel)
						} label: {
							EmptyView()
						}
					}
					.toolbar {
						ToolbarItem(placement: .navigationBarLeading) {
							Button {
								withAnimation(.easeInOut) {
									offset = sideMenuWidth
								}
							} label: {
								UserProfileImageView(url: user.profileImageURL)
									.frame(width: 40, height: 40)
							}
						}
						
						ToolbarItem(placement: .principal) {
							Image("icon")
								.resizable()
								.renderingMode(.template)
								.foregroundColor(.primary)
								.frame(width: 30, height: 30)
						}
					}
				}
			}
			
		}
	}
	
}
