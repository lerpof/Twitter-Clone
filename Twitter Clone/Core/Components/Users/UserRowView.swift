//
//  UserRowView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 25/04/22.
//

import SwiftUI
import Kingfisher

struct UserRowView: View {
    
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            UserProfileImageView(url: user.profileImageURL)
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text("@\(user.username)")
                    .fontWeight(.semibold)
                Text(user.fullname)
            }
            .foregroundColor(.primary)
            Spacer()
        }
        .padding(.leading)
        .padding(.vertical, 8)
    }
}

