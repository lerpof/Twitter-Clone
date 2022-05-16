//
//  ProfileView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/04/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
	
	@ObservedObject private var profileViewModel: ProfileViewModel
	@State private var selectedTab: TweetFilterViewModel = .tweets
	@State private var presentChat: Bool = false
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var viewModel: AuthViewModel
	@Namespace var animation
	
	private let user: User
	
	private var isMyProfile: Bool {
		self.user.email == viewModel.currentUser?.email
	}
	
	init(user: User) {
		self.user = user
		profileViewModel = ProfileViewModel(user: user)
	}
	
    var body: some View {
		VStack(alignment: .leading) {
			
			profileImagesWithBack
			
			profileButtons
			
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
	
	var profileButtons: some View {
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
			
			NavigationButton(showNextView: $presentChat) {
				ZStack {
					Text(isMyProfile ? "Edit Profile" : "Message")
						.fontWeight(.bold)
						.font(.system(size: 14))
						.foregroundColor(.primary)
					RoundedRectangle(cornerRadius: 22)
						.stroke()
						.foregroundColor(.gray)
				}
				.frame(width: 110)
			} destination: {
				ChatView(with: user)
			}
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
