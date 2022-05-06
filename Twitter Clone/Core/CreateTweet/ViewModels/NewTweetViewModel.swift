//
//  NewTweetViewModel.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 02/05/22.
//

import Foundation
import Firebase

class NewTweetViewModel: ObservableObject {
	
	@Published var didUploadTweet = false
	
	private let tweetService = TweetService()
	
	func uploadTweet(with caption: String) {
		tweetService.uploadTweet(caption: caption) { uploaded in
			if uploaded {
				self.didUploadTweet = uploaded
			} else {
				print("DEBUG: not uploaded")
			}
		}
	}
	
}
