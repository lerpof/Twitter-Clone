//
//  TweetRowView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 24/04/22.
//

import SwiftUI

struct TweetRowView: View {
	
	private let tweet: Tweet
	
	@State private var showProfileView: Bool = false
	@State private var showTweetView: Bool = false
	
	@ObservedObject private var tweetRowViewModel: TweetRowViewModel
	
	
	
	init(_ tweet: Tweet, isRow: Bool = true) {
		self.tweet = tweet
		self.tweetRowViewModel = TweetRowViewModel(self.tweet)
	}
	
	var body: some View {
		if let user = tweet.user {
			VStack(alignment: .leading, spacing: 30){
				HStack(alignment: .top, spacing: 12) {
					NavigationButton(showNextView: $showProfileView) {
						UserProfileImageView(url: user.profileImageURL)
							.frame(width: 46, height: 46)
					} destination: {
						ProfileView(user: user)
					}
					
					NavigationButton(showNextView: $showTweetView) {
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
						.foregroundColor(.primary)
					} destination: {
						TweetView(tweet)
					}
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

