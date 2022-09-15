//
//  TweetRowView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/04/22.
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
                    
                    // PROFILE IMAGE NAVIGATION LINK
                    NavigationLink {
                        GeometryReader { proxy in
                            ProfileView(userID: user.id!, topEdge: proxy.safeAreaInsets.top)
                                .navigationBarHidden(true)
                        }
                    } label: {
                        UserProfileImageView(url: user.profileImageURL)
                            .frame(width: 46, height: 46)
                    }

                    
                    VStack(alignment: .leading) {
                        
                        // NAME AND USERNAME NAVIGATION LINK
                        NavigationLink {
                            GeometryReader { proxy in
                                ProfileView(userID: user.id!, topEdge: proxy.safeAreaInsets.top)
                                    .navigationBarHidden(true)
                            }
                        } label: {
                            HStack {
                                Text(user.fullname)
                                    .fontWeight(.bold)
                                    .font(.subheadline)
                                Text("@\(user.username) • \(tweet.timestamp.dateValue().offsetFromNow)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        // TWEET CONTENT NAVIGATION LINK
                        NavigationLink {
                            TweetView(tweet)
                                .navigationBarHidden(true)
                        } label: {
                            Text(tweet.caption)
                                .multilineTextAlignment(.leading)
                                .font(.body)
                        }
                    }
                    .foregroundColor(.primary)
					
				}
				TweetInteractionButtons(tweet)
				.padding(.horizontal, 8)
			}
			.padding(.horizontal)
			.padding(.vertical, 8)
		}
	}
}

