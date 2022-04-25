//
//  ProfileView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 24/04/22.
//

import SwiftUI

struct ProfileView: View {
	
	@State private var selectedTab: TweetFilterViewModel = .tweets
	@Namespace var animation
	
    var body: some View {
		VStack(alignment: .leading) {
			
			profileImagesWithBack
			
			editProfileButtons
			
			userInfo
			
			tweetFilterTabs
			
			TweetsView(filter: selectedTab.title)
			
			Spacer()
		}
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
					debugPrint("go back")
				} label: {
					Image(systemName: "arrow.left")
				}
				.foregroundColor(.white)
				.font(.title2)
				Spacer()
				Circle()
					.frame(width: 60, height: 60)
					.offset(x: 10, y: 25)
			}
			.padding(.leading, 6)
		}
		.ignoresSafeArea()
		.frame(height: 150)
	}
	
	var editProfileButtons: some View {
		HStack {
			Spacer()
			Button {
				
			} label: {
				ZStack {
					Image(systemName: "bell.badge")
						.font(.title2)
						.foregroundColor(.black)
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
						.foregroundColor(.black)
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
					Text("Bruce Wayne")
						.font(.title2)
						.fontWeight(.bold)
					Image(systemName: "checkmark.seal.fill")
						.foregroundColor(.blue)
				}
				Text("@batman")
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
			HStack {
				HStack {
					Text("2")
						.fontWeight(.bold)
					Text("Following")
						.foregroundColor(.gray)
						.font(.system(size: 14))
				}
				HStack {
					Text("4")
						.fontWeight(.bold)
					Text("Followers")
						.foregroundColor(.gray)
						.font(.system(size: 14))
				}
			}
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
						.foregroundColor(isSelected ? .black : .gray)
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

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
		ProfileView()
			.previewDevice(PreviewDevice(rawValue: "iPhone 13"))
			.previewDisplayName("iPhone 13")
//		ProfileView()
//			.previewDevice(PreviewDevice(rawValue: "iPhone 8"))
//			.previewDisplayName("iPhone 8")
    }
}
