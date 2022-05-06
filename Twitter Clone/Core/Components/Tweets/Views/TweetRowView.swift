//
//  TweetRowView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 24/04/22.
//

import SwiftUI

struct TweetRowView: View {
	
	private let tweet: Tweet
	
	@ObservedObject private var tweetRowViewModel: TweetRowViewModel
	
	init(_ tweet: Tweet, isRow: Bool = true) {
		self.tweet = tweet
		self.tweetRowViewModel = TweetRowViewModel(self.tweet)
	}
	
	var body: some View {
		if let user = tweet.user {
			VStack(alignment: .leading, spacing: 30){
				HStack(alignment: .top, spacing: 12) {
					NavigationLink {
						ProfileView(user: user)
							.navigationBarHidden(true)
					} label: {
						UserProfileImageView(url: user.profileImageURL)
							.frame(width: 46, height: 46)
					}
					NavigationLink {
						TweetView(tweet)
							.navigationBarHidden(true)
					} label: {
						VStack(alignment: .leading) {
							HStack {
								Text(user.fullname)
									.fontWeight(.bold)
									.font(.subheadline)
								Text("@\(user.username) • \(tweet.timestamp.seconds / 604800)w")
									.font(.caption)
									.foregroundColor(.gray)
							}
							Text(tweet.caption)
								.multilineTextAlignment(.leading)
								.font(.body)
						}
					}
					.foregroundColor(.primary)
					// TODO: fix week counter
					
				}
				TweetInteractionButtons(tweet)
				.padding(.horizontal, 8)
			}
			.padding(.horizontal)
			.padding(.vertical, 8)
		}
	}
}

