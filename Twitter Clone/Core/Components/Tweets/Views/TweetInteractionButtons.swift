//
//  TweetInteractionButtons.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 06/05/22.
//

import SwiftUI

struct TweetInteractionButtons: View {
	
	@ObservedObject private var tweetRowViewModel: TweetRowViewModel
	
	init(_ tweet: Tweet) {
		self.tweetRowViewModel = TweetRowViewModel(tweet)
	}
	
    var body: some View {
		HStack {
			// Add comment button
			Button {
				debugPrint("Add comment")
			} label: {
				Image(systemName: "bubble.left")
			}
			Spacer()
			// Re-Tweet button
			Button {
				debugPrint("retweet")
			} label: {
				Image(systemName: "arrow.2.squarepath")
			}
			Spacer()
			// Like button
			Button {
				tweetRowViewModel.isLiked ? tweetRowViewModel.unlikeTweet() : tweetRowViewModel.likeTweet()
			} label: {
				Image(systemName: tweetRowViewModel.isLiked ? "heart.fill" : "heart")
					.foregroundColor(tweetRowViewModel.isLiked ? .red : .gray)
			}
			Spacer()
			// Save button
			Button {
				debugPrint("save")
			} label: {
				Image(systemName: "bookmark")
			}
		}
		.foregroundColor(.gray)
    }
}
