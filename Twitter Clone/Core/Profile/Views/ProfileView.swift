//
//  ProfileView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 24/04/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
	
	@ObservedObject private var profileViewModel: ProfileViewModel
	@State private var selectedTab: TweetFilterViewModel = .tweets
	@Environment(\.presentationMode) var presentationMode
	@Namespace var animation
	
	private let user: User
	
	init(user: User) {
		self.user = user
		profileViewModel = ProfileViewModel(user: user)
	}
	
    var body: some View {
		VStack(alignment: .leading) {
			
			profileImagesWithBack
			
			editProfileButtons
			
			userInfo
			
			tweetFilterTabs
			
			TweetsView(profileViewModel.tweets)
			
			Spacer()
		}
		.navigationBarHidden(true)
    }
}

// MARK: - ProfileView Components
extension ProfileView {
	
	var profileImagesWithBack: some View {
		ZStack(alignment: .leading) {
			Color.blue
			VStack {
				Spacer()
				Button {
					presentationMode.wrappedValue.dismiss()
				} label: {
					Image(systemName: "arrow.left")
				}
				.foregroundColor(.white)
				.font(.title2)
				Spacer()
				UserProfileImageView(url: user.profileImageURL)
					.frame(width: 75, height: 75)
					.offset(x: 10, y: 25)
					
			}
			.padding(.leading, 6)
		}
		.ignoresSafeArea()
		.propotionalFrame(width: 1, height: 0.18)
		
		
	}
	
	var editProfileButtons: some View {
		HStack {
			Spacer()
			Button {
				
			} label: {
				ZStack {
					Image(systemName: "bell.badge")
						.font(.title2)
						.foregroundColor(.primary)
					Circle()
						.stroke()
						.foregroundColor(.gray)
				}
			}
			.frame(width: 35)
			
			Button {
				
			} label: {
				ZStack {
					Text("Edit Profile")
						.fontWeight(.bold)
						.font(.system(size: 14))
						.foregroundColor(.primary)
					RoundedRectangle(cornerRadius: 22)
						.stroke()
						.foregroundColor(.gray)
				}
			}
			.frame(width: 110)
		}
		.frame(height: 30)
		.padding(.trailing)
	}
	
	var userInfo: some View {
		VStack(alignment: .leading, spacing: 16) {
			VStack(alignment: .leading) {
				HStack {
					Text(user.fullname)
						.font(.title2)
						.fontWeight(.bold)
					Image(systemName: "checkmark.seal.fill")
						.foregroundColor(.blue)
				}
				Text("@\(user.username)")
					.font(.caption)
					.foregroundColor(.gray)
			}
			Text("Pazz in culo mascherato")
			HStack {
				HStack {
					Image(systemName: "mappin.and.ellipse")
					Text("Gotham City")
						.font(.caption)
				}
				HStack {
					Image(systemName: "link")
					Text("batman.com")
						.font(.caption)
				}
			}
			ProfileFollowView()
		}
		.padding(.horizontal)
	}
	
	var tweetFilterTabs: some View {
		HStack {
			ForEach(TweetFilterViewModel.allCases, id: \.rawValue) { item in
				VStack {
					let isSelected = selectedTab == item
					Text(item.title)
						.font(.subheadline)
						.fontWeight(isSelected ? .semibold : .regular)
						.foregroundColor(isSelected ? .primary : .gray)
					if isSelected {
						Capsule()
							.foregroundColor(.blue)
							.frame(height: 3)
							.matchedGeometryEffect(id: "filter", in: animation)
					}
					else {
						Capsule()
							.foregroundColor(.clear)
							.frame(height: 3)
					}
					
				}
				.onTapGesture {
					withAnimation(.easeInOut) {
						self.selectedTab = item
						self.profileViewModel.fetchTweets(tweetFilter: item)
					}
				}
			}
		}
		.overlay {
			Divider()
				.offset(y: 16)
		}
		.padding(.top)
	}
	
}
