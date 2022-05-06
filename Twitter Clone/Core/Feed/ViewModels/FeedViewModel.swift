//
//  FeedViewModel.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 02/05/22.
//

import Foundation

class FeedViewModel: ObservableObject {
	
	@Published var tweets: [Tweet] = []
	
	let userService = UserService()
	let tweetService = TweetService()
	
	init() {
		fetchTweets()
	}
	
	func fetchTweets() {
		tweetService.fetchTweets { tweets in
			self.tweets = tweets
			for i in 0 ..< self.tweets.count {
				self.userService.fetchUser(withUid: self.tweets[i].uid) { user in
					self.tweets[i].user = user
				}
			}
		}
	}
	
}