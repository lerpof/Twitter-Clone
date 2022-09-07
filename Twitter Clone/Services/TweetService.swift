//
//  TweetService.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 02/05/22.
//

import Firebase

struct TweetService {
	
	func uploadTweet(caption: String, completion: @escaping (Bool) -> Void) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		
		let data: [String: Any] = ["uid": uid,
								   "caption": caption,
								   "likes": 0,
								   "timestamp": Timestamp(date: Date())]
		
		Firestore.firestore().collection("tweets").document()
			.setData(data) { error in
				if error != nil {
					completion(false)
					return
				}
				completion(true)
			}
	}
	
	func fetchTweets(forUser user: User? = nil, completion: @escaping ([Tweet]) -> Void) {
		if let user = user {
			Firestore.firestore().collection("tweets")
				.whereField("uid", isEqualTo: user.id!)
				.getDocuments { snapshot, _ in
					guard let documents = snapshot?.documents else { return }
					var tweets: [Tweet] = []
					for document in documents {
						var tweet = try! document.data(as: Tweet.self)
						tweet.user = user
						tweets.append(tweet)
					}
					completion(tweets)
				}
		} else {
			Firestore.firestore().collection("tweets")
				.order(by: "timestamp", descending: true)
				.getDocuments { snapshot, _ in
					guard let documents = snapshot?.documents else { return }
					let tweets = documents.compactMap {
						try? $0.data(as: Tweet.self)
					}
					completion(tweets)
				}
		}
		
	}
	
	func fetchLikes(withUserID id: String, completion: @escaping ([Tweet]) -> Void) {
        Firestore.firestore().collection("users").document(id)
            .getDocument { snapshot, error in
                if error != nil {
                    print("DEBUG: error fetch likes")
                    return
                }
                guard let snapshot = snapshot else { return }
                let user = try! snapshot.data(as: User.self)
                fetchTweets { tweets in
                    let likedTweets = tweets.filter { user.likes.contains($0.id!) }
                    completion(likedTweets)
                }
            }
	}
	
	func likeTweet(_ tweet: Tweet) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		guard let tweetId = tweet.id else { return }
		
		Firestore.firestore().collection("users").document(uid)
			.updateData([
				"likes": FieldValue.arrayUnion([tweetId])
			])
		
		Firestore.firestore().collection("tweets").document(tweetId)
			.updateData([
				"likes": FieldValue.increment(Int64(1))
			])
		
		
	}
	
	func unlikeTweet(_ tweet: Tweet) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		guard let tweetId = tweet.id else { return }
		
		Firestore.firestore().collection("users").document(uid)
			.updateData([
				"likes": FieldValue.arrayRemove([tweetId])
			])
		
		Firestore.firestore().collection("tweets").document(tweetId)
			.updateData([
				"likes": FieldValue.increment(Int64(-1))
			])
		
	}
	
	func isLiked(_ tweet: Tweet, completion: @escaping (Bool) -> Void) {
		guard let uid = Auth.auth().currentUser?.uid else { return }
		guard let tweetId = tweet.id else { return }
		
		Firestore.firestore().collection("users")
			.document(uid).getDocument { snapshot, _ in
				guard let snapshot = snapshot else { return }
				let user = try! snapshot.data(as: User.self)
				completion(user.likes.contains(tweetId))
			}
	}
}
