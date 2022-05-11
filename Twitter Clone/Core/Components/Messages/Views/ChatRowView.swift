//
//  ChatRowView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 08/05/22.
//

import SwiftUI

struct ChatRowView: View {
	
	@State var showChatView: Bool = false
	
	let chat: Chat
	
    var body: some View {
		NavigationButton(showNextView: $showChatView) {
			HStack(alignment: .top, spacing: 12) {
				Circle()
					.frame(width: 50, height: 50)
				
				VStack(alignment: .leading) {
					HStack {
						Text(chat.recipient!.fullname)
							.fontWeight(.bold)
							.font(.subheadline)
						Text("@\(chat.recipient!.username) • 1w")
							.font(.caption)
							.foregroundColor(.gray)
					}
					
					Text(chat.messages?.last?.body ?? "")
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
			ChatView(with: chat.recipient!)
			//ChatView(chat: chat)
		}

    }
}

