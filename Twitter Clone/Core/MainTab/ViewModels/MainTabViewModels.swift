//
//  MainTabViewModels.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 25/04/22.
//

import SwiftUI

enum MainTabViewModels: Int, CaseIterable {
	case feed
	case explore
	case notification
	case message
	
	var title: String {
		switch self {
		case .feed:
			return "Feed"
		case .explore:
			return "Explore"
		case .notification:
			return "Notifications"
		case .message:
			return "Messages"
		}
	}
	
	var imageName: String {
		switch self {
		case .feed:
			return "house"
		case .explore:
			return "magnifyingglass"
		case .notification:
			return "bell"
		case .message:
			return "envelope"
		}
	}
	
	var view: some View {
		switch self {
		case .feed:
			return AnyView(FeedView())
		case .explore:
            return AnyView(ExploreView(destinationType: .profile))
		case .notification:
			return AnyView(NotificationsView())
		case .message:
			return AnyView(ChatsListView())
		}
	}
	
}
