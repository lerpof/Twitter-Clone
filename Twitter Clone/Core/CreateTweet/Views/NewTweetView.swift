//
//  NewTweetView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 25/04/22.
//

import SwiftUI

struct NewTweetView: View {
	@State private var caption = ""
	@Environment(\.presentationMode) var presentationMode
	@EnvironmentObject var authViewModel: AuthViewModel
	@ObservedObject var viewModel = NewTweetViewModel()
	
    var body: some View {
		VStack {
			HStack {
				Button {
					presentationMode.wrappedValue.dismiss()
				} label: {
					Text("Cancel")
						.foregroundColor(.blue)
				}
				Spacer()
				Button {
					viewModel.uploadTweet(with: caption)
				} label: {
					Text("Tweet")
						.bold()
						.padding(.horizontal)
						.padding(.vertical, 8)
						.background(Color(.systemBlue))
						.foregroundColor(.white)
						.clipShape(Capsule())
				}

			}
			HStack(alignment: .top) {
				if let user = authViewModel.currentUser {
					UserProfileImageView(url: user.profileImageURL)
						.frame(width: 64, height: 64)
				}
				TextAreaView("What's happening?", text: $caption)
			}
		}
		.padding()
		.onReceive(viewModel.$didUploadTweet) { success in
			if success {
				presentationMode.wrappedValue.dismiss()
			}
		}
    }
}

struct NewTweetView_Previews: PreviewProvider {
    static var previews: some View {
        NewTweetView()
    }
}
