//
//  MessagesView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 09/05/22.
//

import SwiftUI

struct MessagesView: View {
	
	@ObservedObject var messageViewModel = MessagesViewModel()
	
    var body: some View {
		ScrollView {
			LazyVStack {
				ForEach(messageViewModel.chats) { chat in
					ChatRowView()
					Divider()
				}
			}
		}
    }
}

struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
