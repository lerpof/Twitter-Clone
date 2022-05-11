//
//  UserProfileImageView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 29/04/22.
//

import SwiftUI
import Kingfisher

struct UserProfileImageView: View {
	
	let url: String
	
    var body: some View {
		KFImage(URL(string: url))
			.resizable()
			.scaledToFill()
			.clipShape(Circle())
    }
}

struct UserProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileImageView(url: "")
    }
}
