//
//  MainTabView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 24/04/22.
//

import SwiftUI

struct MainTabView: View {
	
	@State private var selectedIndex = 0
	
    var body: some View {
		TabView(selection: $selectedIndex) {
			FeedView()
				.onTapGesture {
					self.selectedIndex = 0
				}
				.tabItem {
					Image(systemName: "house")
				}
				.tag(0)
			
			ExploreView()
				.onTapGesture {
					self.selectedIndex = 0
				}
				.tabItem {
					Image(systemName: "magnifyingglass")
				}
				.tag(0)
			
			NotificationsView()
				.onTapGesture {
					self.selectedIndex = 0
				}
				.tabItem {
					Image(systemName: "bell")
				}
				.tag(0)
			
			MessagesView()
				.onTapGesture {
					self.selectedIndex = 3
				}
				.tabItem {
					Image(systemName: "envelope")
				}
				.tag(3)
		}
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
