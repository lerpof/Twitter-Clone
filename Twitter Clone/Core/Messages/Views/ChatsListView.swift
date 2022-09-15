//
//  MessagesView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 09/05/22.
//

import SwiftUI

struct ChatsListView: View {
	
	@StateObject var chatsListViewModel = ChatsListViewModel()
    @State var showUsersList = false
    
    @State var goToChat = false
	
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                SearchBarView(text: $chatsListViewModel.searchBarText)
                    .padding()
                Spacer()
                ScrollViewReader { value in
                    ScrollView {
                        ForEach(chatsListViewModel.searchableChat, id: \.id) { chat in
                            ChatRowView(chat: chat)
                                .id(chat.id)
                            Divider()
                        }
                    }
                    .onAppear {
                        value.scrollTo(chatsListViewModel.chats.first?.id!)
                    }
                    .onChange(of: chatsListViewModel.chats.count) { _ in
                        value.scrollTo(chatsListViewModel.chats.first?.id!)
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
            
            if let recipient = chatsListViewModel.selectedUser {
                NavigationLink(isActive: $goToChat) {
                    ChatView(recipient: recipient)
                        .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
            }
        }
        .sheet(isPresented: $showUsersList, onDismiss: {
            goToChat = chatsListViewModel.selectedUser != nil
        }, content: {
            ExploreView(destinationType: .chat)
                .environmentObject(chatsListViewModel)
                .navigationBarHidden(true)
        })
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        ChatsListView()
    }
}
