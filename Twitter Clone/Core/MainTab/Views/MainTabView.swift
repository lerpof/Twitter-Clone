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
			SideBarStack(sidebarWidth: sideMenuWidth, offset: $offset) {
				SideMenuView()
			} content: {
				VStack {
					MainNavigationBar(offset: $offset, sideMenuWidth: sideMenuWidth)
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
				}
			}
		}
	}
	
}
