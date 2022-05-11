//
//  UserRowView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 25/04/22.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
	
	let user: User
	@State var showProfileView = false
	
    var body: some View {
		NavigationButton(showNextView: $showProfileView) {
			HStack(spacing: 12) {
				UserProfileImageView(url: user.profileImageURL)
					.frame(width: 50, height: 50)
				VStack(alignment: .leading) {
					Text("@\(user.username)")
						.fontWeight(.semibold)
					Text(user.fullname)
				}
				.foregroundColor(.primary)
				Spacer()
			}
			.padding(.leading)
			.padding(.vertical, 8)
		} destination: {
			ProfileView(user: user)
		}
    }
}

