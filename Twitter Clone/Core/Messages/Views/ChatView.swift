//
//  MessagesView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/04/22.
//

import SwiftUI

struct ChatView: View {
    
    @State var message: String = ""
    @ObservedObject var chatViewModel: ChatViewModel
    
    init(recipient: User) {
        chatViewModel = ChatViewModel(with: recipient)
    }
    
    var body: some View {
        VStack {
            NavBarWithBack {
                HStack {
                    if let recipient = chatViewModel.chat?.recipient {
                        UserProfileImageView(url: recipient.profileImageURL)
                            .frame(width: 30, height: 30)
                        Text(recipient.fullname)
                    }
                }
            }
            
            Spacer()
            
            ScrollViewReader { value in
                ScrollView {
                    VStack {
                        if let messages = chatViewModel.chat?.messages {
                            ForEach(messages, id: \.id) { message in
                                SingleMessageView(message: message)
                                    .id(message.id)
                                    .flippedUpsideDown()
                            }
                        }
                        
                    }
                }
                //                    .onAppear {
                //                        value.scrollTo(messages.first?.id!)
                //                    }
                //                    .onChange(of: messages.count) { _ in
                //                        value.scrollTo(messages.first?.id!)
                //                    }
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
        .onAppear {
            chatViewModel.fetchData()
        }

    }
}

