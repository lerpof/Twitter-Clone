//
//  TweetRowView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 24/04/22.
//

import SwiftUI

struct TweetRowView: View {
    var body: some View {
		VStack(alignment: .leading, spacing: 30){
			HStack(alignment: .top, spacing: 12) {
				Circle()
					.frame(width: 46, height: 46)
				VStack(alignment: .leading) {
					Text("Bruce Wayne")
						.fontWeight(.bold)
						.font(.subheadline)
					Text("Tweet body")
						.font(.body)
				}
				Text("@batman • 49w")
					.font(.caption)
					.foregroundColor(.gray)
				
			}
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
					debugPrint("like")
				} label: {
					Image(systemName: "heart")
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
			.padding(.horizontal, 8)
		}
		.padding(.horizontal)
		.padding(.vertical, 8)
    }
}

struct TweetRowView_Previews: PreviewProvider {
    static var previews: some View {
		TweetRowView()
			.previewLayout(.sizeThatFits)
    }
}
