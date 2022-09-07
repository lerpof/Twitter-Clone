//
//  EditProfileView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 25/05/22.
//

import SwiftUI
import Kingfisher

struct EditProfileView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var editProfileViewModel: EditProfileViewModel
    private let baseHeight = (UIScreen.main.bounds.width / 21) * 9
    
    @State private var showingProfileImagePicker = false
    @State private var showingCoverImagePicker = false
    
    @State private var profileImage: Image?
    @State private var profileImageChoosed: UIImage?
    @State private var profileImageCropped: UIImage?
    
    @State private var coverImage: Image?
    @State private var coverImageChoosed: UIImage?
    @State private var coverImageCropped: UIImage?
    
    // MARK: State properties for user data
    @State private var fullname: String
    @State private var bio: String 
    @State private var location: String
    @State private var website: String
    @State private var birthDate: Date
    
    @State private var fullnameIsValid: Bool = true
    @State private var bioIsValid: Bool = true
    @State private var locationIsValid: Bool = true
    @State private var websiteIsValid: Bool = true
    @State private var birthDateIsValid: Bool = true
    
    var isSaveEnabled: Bool {
        return fullnameIsValid && bioIsValid && locationIsValid && websiteIsValid && birthDateIsValid
    }
    
    init(_ user: User) {
        editProfileViewModel = EditProfileViewModel(user)
        _fullname = State(initialValue: user.fullname)
        _bio = State(initialValue: user.bio)
        _location = State(initialValue: user.location)
        _website = State(initialValue: user.website)
        _birthDate = State(initialValue: user.birthDate.dateValue())
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    VStack(alignment: .leading, spacing: 0) {
                        
                        headerView

                        Group {
                            profileButtons
                            
                            VStack {
                                EditProfileRowView(title: "Name", placeholder: "Name...", content: $fullname.onChange(validateFullname))
                                EditProfileRowView(title: "Bio", placeholder: "Add bio to your profile...", content: $bio)
                                EditProfileRowView(title: "Location", placeholder: "Add your location...", content: $location)
                                EditProfileRowView(title: "Website", placeholder: "Add website to your profile...", content: $website)
                                
                                VStack {
                                    Divider()
                                    HStack {
                                        Text("Birth date")
                                            .fontWeight(.bold)
                                            .frame(width: 100, alignment: .leading)
                                        DatePicker("", selection: $birthDate, in: ...Date(), displayedComponents: .date)
                                    }
                                    .frame(height: 35)
                                    .padding(.horizontal)
                                }
                                
                            }
                            .padding(.top)
                        }
                        .offset(y: -25)
                        
                        Spacer()
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Cancel")
                            .font(.headline)
                            .foregroundColor(.gray)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Edit Profile")
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        editProfileViewModel.updateData(fullname: fullname,
                                                        bio: bio,
                                                        location: location,
                                                        website: website,
                                                        birthDate: birthDate,
                                                        profileImage: profileImageChoosed,
                                                        coverImage: coverImageChoosed)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                            .fontWeight(.bold)
                            .font(.headline)
                            .foregroundColor(isSaveEnabled ? .blue : .gray)
                    }
                    .disabled(!(isSaveEnabled))

                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
        }
    }
    
}

// MARK: - EditProfile functions
extension EditProfileView {
    func loadProfileImage() {
        guard let profileImageChoosed = profileImageChoosed else {
            return
        }
        profileImage = Image(uiImage: profileImageChoosed)
    }
    
    func loadCoverImage() {
        if let coverImageChoosed = self.coverImageChoosed {
            coverImage = Image(uiImage: coverImageChoosed)
        }
    }
    
    func validateFullname(fullName: String) {
        if fullname.isEmpty {
            fullnameIsValid = false
        } else {
            fullnameIsValid = true
        }
    }
    
    func validateBio(bio: String) {
        bioIsValid = true
    }
    
    func validateLocation(location: String) {
        if fullname.isEmpty {
            locationIsValid = false
        } else {
            locationIsValid = true
        }
    }
    
    func validateWebsite(website: String) {
        websiteIsValid = true
    }
    
    func validateBirthDate(birthDate: Date) {
        birthDateIsValid = true
    }
}

// MARK: - ProfileView Components
extension EditProfileView {
    
    private var headerView: some View {
        Color.blue
            .frame(width: rect.width, height: baseHeight)
//        Button {
//            showingCoverImagePicker.toggle()
//        } label: {
//            KFImage(URL(string: editProfileViewModel.user.coverImageURL))
//                .resizable()
//                .scaledToFill()
//                .frame(width: rect.width, height: baseHeight)
//                .overlay {
//                    Image(systemName: "camera.fill")
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 20, height: 20)
//                        .padding(15)
//                        .overlay {
//                            Circle()
//                                .foregroundColor(.black)
//                                .opacity(0.3)
//                        }
//                }
//        }
//        .sheet(isPresented: $showingCoverImagePicker,
//               onDismiss: loadCoverImage) {
//            ImagePicker(image: $coverImageChoosed, showImageCropper: $showingCoverImageCropper)
//                .sheet(isPresented: $showingCoverImageCropper) {
//                    if let coverImageChoosed = coverImageChoosed {
//                        ImageCropperView(shown: $showingCoverImageCropper,
//                                         image: coverImageChoosed,
//                                         croppedImage: $coverImageCropped)
//                    }
//                }
//        }
    }
    
    private var profileButtons: some View {
        HStack(alignment: .bottom) {
            Button {
                showingProfileImagePicker.toggle()
            } label: {
                Group {
                    if let profileImage = profileImage {
                        profileImage
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    } else {
                        UserProfileImageView(url: editProfileViewModel.user.profileImageURL)
                    }
                }
                .overlay(
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 2)
                            .foregroundColor(Color("background"))
                        Image(systemName: "camera.fill")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .padding(15)
                        Circle()
                            .foregroundColor(.black)
                            .opacity(0.3)
                    }
                )
                .frame(width: 60, height: 60)
            }
            Spacer()

        }
        .padding(.horizontal)
        .sheet(isPresented: $showingProfileImagePicker,
               onDismiss: loadProfileImage) {
            ImagePicker(image: $profileImageChoosed, shouldEdit: true)
        }
    }
    
}

struct EditProfileRowView: View {
    let title: String
    let placeholder: String
    @Binding var content: String
    
    var body: some View {
        VStack {
            Divider()
            HStack {
                Text(title)
                    .fontWeight(.bold)
                    .frame(width: 100, alignment: .leading)
                TextField(placeholder, text: $content)
                    .foregroundColor(content.isEmpty ? .gray : .blue)
            }
            .frame(height: 35)
            .padding(.horizontal)
        }
    }
}


