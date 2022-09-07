//
//  ProfilePhotoSelectorView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 27/04/22.
//

import SwiftUI

struct SignupView: View {
	
	@State private var email: String = ""
	@State private var password: String = ""
	@State private var fullname: String = ""
	@State private var username: String = ""
    @State private var birthDate: Date = Date()
	
    @State private var showingImageCropper = false
	@State private var showingImagePicker = false
	@State private var image: Image?
	@State private var imageChoosed: UIImage?
	
	@Environment(\.presentationMode) private var presentationMode
	@EnvironmentObject var viewModel: AuthViewModel
	
    var body: some View {
		VStack {
			AuthenticationHeaderView(title: "Fill all data and",
									 subtitle: "Select a profile photo",
									 leadingPadding: 20)
				.ignoresSafeArea()
			
			VStack {
				HStack(alignment: .center) {
					Button {
						showingImagePicker = true
					} label:  {
						if let image = image {
							image
								.resizable()
								.scaledToFill()
								.frame(width: 100, height: 100)
								.clipShape(Circle())
								.overlay(Circle().stroke(lineWidth: 2))
						} else {
							ZStack {
								Circle()
									.opacity(0.3)
								Image(systemName: "person.badge.plus")
									.resizable()
									.foregroundColor(Color(.systemBlue))
									.frame(width: 60, height: 60)
							}
							.frame(width: 100, height: 100)
							.overlay(Circle().stroke(lineWidth: 2))
						}
						
					}
					
					VStack(alignment: .leading) {
						CustomTextField(image: "person", placeholder: "Full name", text: $fullname, isSecureInput: false)
						Spacer()
							.frame(minHeight: 20, maxHeight: 35)
						CustomTextField(image: "person", placeholder: "Username", text: $username, isSecureInput: false)
					}
				}
				
				Spacer()
					.frame(minHeight: 20, maxHeight: 35)
				
				CustomTextField(image: "envelope", placeholder: "Email", text: $email, isSecureInput: false)
				
				Spacer()
					.frame(minHeight: 20, maxHeight: 35)
				
				CustomTextField(image: "lock", placeholder: "Password", text: $password, isSecureInput: true)
				
				Spacer()
					.frame(minHeight: 20, maxHeight: 35)
                
                DatePicker(selection: $birthDate, in: ...Date(), displayedComponents: .date) {
                    Text("Birth date")
                }
				
				AuthButton(with: "Continue") {
					viewModel.register(withEmail: email,
									   password: password,
									   fullname: fullname,
									   username: username,
                                       birthDate: birthDate,
									   image: imageChoosed ?? UIImage(systemName: "person.circle.fill")!)
				}
				
				Spacer()
				
				Button {
					presentationMode.wrappedValue.dismiss()
				} label: {
					HStack {
						Text("Already have an account?")
							.font(.callout)
						Text("Sign In")
							.font(.callout)
							.fontWeight(.semibold)
						
					}
				}
				.padding(.bottom)
				
			}
			.padding(.horizontal, 20)
		}
		.sheet(isPresented: $showingImagePicker,
			   onDismiss: loadImage) {
			ImagePicker(image: $imageChoosed, shouldEdit: true)
		}
    }
	
	func loadImage() {
		guard let imageChoosed = imageChoosed else {
			return
		}
		image = Image(uiImage: imageChoosed)
	}
	
}

struct ProfilePhotoSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
			.previewDevice(PreviewDevice(rawValue: "iPhone 13"))
		
		SignupView()
			.previewDevice(PreviewDevice(rawValue: "iPod touch (7th generation)"))
    }
}
