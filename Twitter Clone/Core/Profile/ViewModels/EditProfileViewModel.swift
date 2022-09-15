//
//  EditProfileViewModfe.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 06/06/22.
//

import SwiftUI
import Firebase

class EditProfileViewModel: ObservableObject {
    
    let user: User
    
    let userService = UserService()
    
    init(_ user: User) {
        self.user = user
    }
    
    func updateData(fullname: String,
                    bio: String,
                    location: String,
                    website: String,
                    birthDate: Date,
                    profileImage: UIImage?,
                    coverImage: UIImage?) {
        var data: [String: Any] = ["fullname" : fullname,
                                   "bio": bio,
                                   "location": location,
                                   "website": website,
                                   "birthDate": Timestamp(date: birthDate)]
        if let profileImage = profileImage, let coverImage = coverImage {
            ImageUploader.uploadImage(image: profileImage, purpose: .profile) { profileImageUrl in
                ImageUploader.uploadImage(image: coverImage, purpose: .cover) { coverImageUrl in
                    data["profileImageURL"] = coverImageUrl
                    data["profileImageURL"] = profileImageUrl
                    self.userService.updateUser(userID: self.user.id!, with: data)
                }
            }
        } else if let coverImage = coverImage  {
            ImageUploader.uploadImage(image: coverImage, purpose: .cover) { coverImageUrl in
                data["profileImageURL"] = coverImageUrl
                self.userService.updateUser(userID: self.user.id!, with: data)
            }
        } else if let profileImage = profileImage {
            ImageUploader.uploadImage(image: profileImage, purpose: .profile) { profileImageUrl in
                data["profileImageURL"] = profileImageUrl
                self.userService.updateUser(userID: self.user.id!, with: data)
            }
        } else {
            userService.updateUser(userID: user.id!, with: data)
        }
    }
    
    
    
}
