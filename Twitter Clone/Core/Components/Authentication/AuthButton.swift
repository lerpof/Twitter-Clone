//
//  AuthButton.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 26/04/22.
//

import SwiftUI

struct AuthButton: View {
	let text: String
	
	let action: (() -> Void)
	
	init(with text: String, action: @escaping (() -> Void)) {
		self.action = action
		self.text = text
	}
	
	var body: some View {
		Button(action: action) {
			Text(text)
				.fontWeight(.bold)
		}
		.frame(maxWidth: .infinity, minHeight: 45, alignment: .center)
		.foregroundColor(.white.opacity(0.9))
		.background(Color(.systemBlue))
		.clipShape(Capsule())
		.shadow(color: .gray.opacity(0.5), radius: 10, x: 0, y: 0)
	}
}

struct AuthButton_Previews: PreviewProvider {
	static var previews: some View {
		AuthButton(with: "Sign in") {
			print("Some sign in")
		}
	}
}
