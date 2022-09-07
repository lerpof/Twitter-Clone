//
//  ExploreView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 24/04/22.
//

import SwiftUI

struct ExploreView: View {
	
	@ObservedObject var viewModel = ExploreViewModel()
    @EnvironmentObject var messagesViewModel: MessagesViewModel
    
    @Environment(\.presentationMode) var presentationMode

    @State var showNextView = false
    let destinationType: ExploreViewDestination
	
    var body: some View {
		VStack {
			SearchBarView(text: $viewModel.searchText)
				.padding()
			ScrollView {
				LazyVStack {
					ForEach(viewModel.searchableUsers) { user in
                        Button {
                            setDestination(with: user)
                        } label: {
                            UserRowView(user: user)
                        }
					}
				}
			}
            NavigationLink(isActive: $showNextView) {
                if let user = viewModel.selectedUser {
                    AnyView(
                        GeometryReader { proxy in
                            ProfileView(user: user, topEdge: proxy.safeAreaInsets.top)
                                .navigationBarHidden(true)
                        })
                }
            } label: {
                EmptyView()
            }

		}
    }
    
    func setDestination(with user: User) {
        switch destinationType {
            case .profile:
                viewModel.selectedUser = user
                showNextView.toggle()
            case .chat:
                messagesViewModel.selectedUser = user
                presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView(destinationType: .profile)
    }
}
