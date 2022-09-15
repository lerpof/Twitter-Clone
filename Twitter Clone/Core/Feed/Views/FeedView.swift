//
//  FeedView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/04/22.
//

import SwiftUI

struct FeedView: View {
	
	@ObservedObject private var feedViewModel = FeedViewModel()
	
	@State private var showNewTweetView = false
	
    var body: some View {
        BaseDataView(with: feedViewModel) {
            ZStack(alignment: .bottomTrailing) {
                TweetsView(feedViewModel.tweets)
                Button {
                    showNewTweetView.toggle()
                } label: {
                    Image(systemName: "text.quote")
                        .font(.title)
                        .padding()
                }
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Circle())
                .padding()
            }
            .sheet(isPresented: $showNewTweetView) {
                feedViewModel.fetchTweets()
            } content: {
                NewTweetView()
            }
        }

    }
}
