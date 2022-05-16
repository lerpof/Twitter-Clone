//
//  MessagesView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 09/05/22.
//

import SwiftUI

struct MessagesView: View {
	
	@ObservedObject var messageViewModel: MessagesViewModel
	
	init() {
		messageViewModel = MessagesViewModel()
	}
	
    var body: some View {
		ScrollViewReader { value in
			ScrollView {
				ForEach(messageViewModel.chats, id: \.id) { chat in
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
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
