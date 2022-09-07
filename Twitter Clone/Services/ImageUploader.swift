//
//  ImageUploader.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 28/04/22.
//

import FirebaseStorage
import UIKit

struct ImageUploader {
	
    static func uploadImage(image: UIImage, purpose: UserImageType, completion: @escaping(String) -> Void) {
		guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
		
		let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/\(purpose.folderName)/\(filename).jpg")
		
		ref.putData(imageData, metadata: nil) { _, error in
			if let error = error {
				print("DEBUG: Failed to upload image with error: \(error.localizedDescription)")
				return
			}
			
			ref.downloadURL { imageURL, _ in
				guard let imageURL = imageURL?.absoluteString else { return }
				completion(imageURL)
			}
		}
	}
	
}

enum UserImageType {
    case profile
    case cover
    
    var folderName: String {
        switch self {
            case .profile:
                return "profile_image"
            case .cover:
                return "cover_image"
        }
    }
}
