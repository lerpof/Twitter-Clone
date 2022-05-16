//
//  AuthenticationHeaderView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 26/04/22.
//

import SwiftUI

struct AuthenticationHeaderView: View {
	let title: String
	let subtitle: String
	let leadingPadding: Double
	
	init(title: String, subtitle: String, leadingPadding: Double? = nil) {
		self.title = title
		self.subtitle = subtitle
		self.leadingPadding = leadingPadding ?? 0
	}
	
    var body: some View {
		// header view
		HStack {
			VStack(alignment: .leading) {
				Text(title)
					.font(.largeTitle)
					.fontWeight(.semibold)
				Text(subtitle)
					.font(.largeTitle)
					.fontWeight(.semibold)
			}
			.padding(.leading, leadingPadding)
			Spacer()
		}
		.propotionalFrame(width: 1, height: 0.3)
		.background(Color(.systemBlue))
		.foregroundColor(.white)
		.clipShape(RoundedShape(corners: [.bottomRight]))
		.shadow(color: .gray.opacity(1), radius: 10, x: 0, y: 0)
    }
}

struct AuthenticationHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationHeaderView(title: "Get started.", subtitle: "Create your account")
    }
}
