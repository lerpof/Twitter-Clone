//
//  SideMenuRowView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 25/04/22.
//

import SwiftUI

struct SideMenuRowView: View {
	let viewModel: SideMenuViewModel
	
    var body: some View {
		HStack(spacing: 12) {
			Image(systemName: viewModel.imageName)
			Text(viewModel.title)
		}
		.foregroundColor(.primary)
		.padding(.vertical)
    }
}

struct SideMenuRowView_Previews: PreviewProvider {
    static var previews: some View {
		SideMenuRowView(viewModel: SideMenuViewModel.profile)
    }
}
