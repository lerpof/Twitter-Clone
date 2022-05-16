//
//  TweetRowViewModel.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 02/05/22.
//

import Foundation
import Firebase

class TweetRowViewModel: ObservableObject {
	
	@Published var isLiked: Bool = false
	private var tweet: Tweet
	private let tweetService = TweetService()
	
	init(_ tweet: Tweet) {
		self.tweet = tweet
		checkIfLiked()
	}
	
	func likeTweet() {
		tweetService.likeTweet(tweet)
		isLiked = true
	}
	
	func unlikeTweet() {
		tweetService.unlikeTweet(tweet)
		isLiked = false
	}
	
	private func checkIfLiked() {
		tweetService.isLiked(self.tweet) { isLiked in
			self.isLiked = isLiked
		}
	}
	
	
	
}
