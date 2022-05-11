//
//  ChatRowView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 08/05/22.
//

import SwiftUI

struct ChatRowView: View {
	
	@State var showChatView: Bool = false
	
	//let chat: Chat
	
    var body: some View {
		NavigationButton(showNextView: $showChatView) {
			HStack(alignment: .top, spacing: 12) {
				Circle()
					.frame(width: 50, height: 50)
				
				VStack(alignment: .leading) {
					HStack {
						Text("Leonardo Lazzari")
							.fontWeight(.bold)
							.font(.subheadline)
						Text("@lerpof • 1w")
							.font(.caption)
							.foregroundColor(.gray)
					}
					
					Text("I have something to say to you, you can't whatever you want and pretend to be with me, you stupid idiot.")
						.truncationMode(.tail)
						.lineLimit(2)
						.multilineTextAlignment(.leading)
						.font(.callout)
						.foregroundColor(.gray)
				}
				.foregroundColor(.primary)
				Spacer()
			}
			.padding(.horizontal)
		} destination: {
			Text("CHAT")
			//ChatView(chat: chat)
		}

    }
}

