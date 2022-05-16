//
//  ChatRowView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 08/05/22.
//

import SwiftUI

struct ChatRowView: View {
	
	@State var showChatView: Bool = false
	
	@State var chat: Chat
	
    var body: some View {
		if let recipient = chat.recipient,
		   let lastMessage = chat.lastMessage {
			NavigationButton(showNextView: $showChatView) {
				HStack(alignment: .top, spacing: 12) {
					UserProfileImageView(url: recipient.profileImageURL)
						.frame(width: 50, height: 50)
					
					VStack(alignment: .leading) {
						HStack {
							Text(recipient.fullname)
								.fontWeight(.bold)
								.font(.subheadline)
							Text("@\(recipient.username) • \(lastMessage.timestamp.dateValue().offsetFromNow)")
								.font(.caption)
								.foregroundColor(.gray)
						}
						
						Text(lastMessage.body)
							.truncationMode(.tail)
							.lineLimit(2)
							.multilineTextAlignment(.leading)
							.font(.callout)
							.foregroundColor(.gray)
					}
					.foregroundColor(.primary)
					Spacer()
				}
				.padding(.vertical, 8)
				.padding(.horizontal)
			} destination: {
				ChatView(with: recipient)
				//ChatView(chat: chat)
			}
		}
		

    }
}

