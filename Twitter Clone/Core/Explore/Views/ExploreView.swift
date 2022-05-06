//
//  ExploreView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 24/04/22.
//

import SwiftUI

struct ExploreView: View {
	
	@ObservedObject var viewModel = ExploreViewModel()
	
    var body: some View {
		VStack {
			SearchBarView(text: $viewModel.searchText)
				.padding()
			ScrollView {
				LazyVStack {
					ForEach(viewModel.searchableUsers) { user in
						NavigationLink {
							ProfileView(user: user)
						} label: {
							UserRowView(user: user)
						}
					}
				}
			}
		}
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}
