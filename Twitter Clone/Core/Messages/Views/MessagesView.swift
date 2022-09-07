//
//  MessagesView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 09/05/22.
//

import SwiftUI

struct MessagesView: View {
	
	@StateObject var messageViewModel = MessagesViewModel()
    @State var showUsersList = false
    
    @State var goToChat = false
	
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                SearchBarView(text: $messageViewModel.searchBarText)
                    .padding()
                Spacer()
                ScrollViewReader { value in
                    ScrollView {
                        ForEach(messageViewModel.searchableChat, id: \.id) { chat in
                            ChatRowView(chat: chat)
                                .id(chat.id)
                            Divider()
                        }
                    }
                    .onAppear {
                        value.scrollTo(messageViewModel.chats.first?.id!)
                    }
                    .onChange(of: messageViewModel.chats.count) { _ in
                        value.scrollTo(messageViewModel.chats.first?.id!)
                    }
                }
            }
            Button {
                showUsersList.toggle()
            } label: {
                Image(systemName: "pencil")
                    .font(.title)
                    .padding()
            }
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Circle())
            .padding()
            
            if let recipient = messageViewModel.selectedUser {
                NavigationLink(isActive: $goToChat) {
                    ChatView(recipient: recipient)
                        .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
            }
        }
        .sheet(isPresented: $showUsersList, onDismiss: {
            goToChat = messageViewModel.selectedUser != nil
        }, content: {
            ExploreView(destinationType: .chat)
                .environmentObject(messageViewModel)
                .navigationBarHidden(true)
        })
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
