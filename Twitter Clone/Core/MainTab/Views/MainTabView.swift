//
//  MainTabView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 24/04/22.
//

import SwiftUI
import Kingfisher

struct MainTabView: View {
	
	@State private var selectedIndex: MainTabViewModels = .feed
	
	private let sideMenuWidth: Double = UIScreen.main.bounds.width * 0.7
	@State private var offset: Double = 0
	
	@EnvironmentObject var viewModel: AuthViewModel
	
	var body: some View {
		if let user = viewModel.currentUser {
			NavigationView {
				SideBarStack(sidebarWidth: sideMenuWidth, offset: $offset) {
					SideMenuView()
						.navigationBarHidden(true)
						.navigationBarTitle(Text("Home"))
				} content: {
					NavigationView {
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
						.navigationBarTitleDisplayMode(.inline)
						.navigationViewStyle(.stack)
						.toolbar {
							ToolbarItem(placement: .navigationBarLeading) {
								Button {
									withAnimation {
										offset = sideMenuWidth
									}
								} label: {
									UserProfileImageView(url: user.profileImageURL)
										.frame(width: 40, height: 40)
								}

							}
							ToolbarItem(placement: .principal) {
								Image("icon")
									.renderingMode(.template)
									.resizable()
									.frame(width: 40, height: 40)
									.foregroundColor(.primary)
							}
						}
					}
				}
			}
		}
	}
	
}
