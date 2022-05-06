//
//  ProfileFollowView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 25/04/22.
//

import SwiftUI

struct ProfileFollowView: View {
    var body: some View {
		HStack {
			HStack {
				Text("2")
					.fontWeight(.bold)
				Text("Following")
					.foregroundColor(.gray)
					.font(.system(size: 14))
			}
			HStack {
				Text("4")
					.fontWeight(.bold)
				Text("Followers")
					.foregroundColor(.gray)
					.font(.system(size: 14))
			}
			Spacer()
		}
    }
}

struct ProfileFollowView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFollowView()
			.previewLayout(.sizeThatFits)
    }
}
