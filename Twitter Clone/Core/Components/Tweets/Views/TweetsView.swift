//
//  TweetsView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 25/04/22.
//

import SwiftUI

struct TweetsView: View {
	
	private let tweets: [Tweet]
	
	init(_ tweets: [Tweet]) {
		self.tweets = tweets
	}
	
    var body: some View {
		ScrollView {
			LazyVStack {
				ForEach(tweets) { tweet in
					TweetRowView(tweet)
					Divider()
				}
			}
		}
    }
}

