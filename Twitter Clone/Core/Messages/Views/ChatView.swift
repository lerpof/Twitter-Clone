//
//  MessagesView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/04/22.
//

import SwiftUI

struct ChatView: View {

	@State var message: String = ""
	@ObservedObject private var chatViewModel: ChatViewModel
	
	init(with user: User) {
		chatViewModel = ChatViewModel(with: user)
	}
	
    var body: some View {
		if let chat = chatViewModel.chat {
			VStack {
				NavBarWithBack {
					HStack {
						UserProfileImageView(url: chat.recipient!.profileImageURL)
							.frame(width: 30, height: 30)
						Text(chat.recipient!.fullname)
					}
				}
				
				Spacer()
				
				ScrollViewReader { value in
					ScrollView {
						ForEach(chat.messages, id: \.id) { message in
							SingleMessageView(message: message)
								.id(message.id)
								.flippedUpsideDown()
						}
					}
					.onAppear {
						value.scrollTo(chat.messages.first?.id!)
					}
					.onChange(of: chat.messages.count) { _ in
						value.scrollTo(chat.messages.first?.id!)
					}
				}
				.padding(.horizontal)
				.flippedUpsideDown()
				
				HStack(spacing: 8) {
					CustomTextField(image: "envelope.fill",
									placeholder: "Message...",
									text: $message,
									isSecureInput: false)
					Button {
						chatViewModel.sendMessage(with: message) { successfullySent in
							if successfullySent {
								self.message = ""
							}
						}
					} label: {
						Image(systemName: "paperplane.fill")
							.resizable()
							.frame(width: 25, height: 25)
							.foregroundColor(.primary)
					}

				}.padding()
			}
		}
    }
}

