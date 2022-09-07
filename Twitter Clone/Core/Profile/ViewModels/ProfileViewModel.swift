//
//  ProfileViewModel.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 02/05/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
	
	@Published var tweets: [Tweet] = []
	private let tweetService = TweetService()
	private let userService = UserService()
	private let messageService = ChatService()
    private let userID: String
    private(set) var user: User?
	
	init(userID: String) {
		self.userID = userID
        self.refreshUser()
	}
	
    func fetchTweets(tweetFilter: TweetFilterViewModel) {
		switch tweetFilter {
		case .tweets:
			tweetService.fetchTweets(forUser: user) { tweets in
				self.tweets = tweets
			}
		case .replies:
			print("DEBUG: replies filter")
		case .likes:
			tweetService.fetchLikes(withUserID: userID) { tweets in
				self.tweets = tweets
				for i in 0 ..< self.tweets.count {
					self.userService.fetchUser(withUid: self.tweets[i].uid) { user in
						self.tweets[i].user = user
					}
				}
			}
		}
	}
    
    func refreshUser() {
        userService.fetchUser(withUid: userID) { user in
            self.user = user
            self.fetchTweets(tweetFilter: .tweets)
        }
    }
	
}
