//
//  ImageUploader.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 28/04/22.
//

import Firebase
import UIKit

struct ImageUploader {
	
	static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
		guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
		
		let filename = NSUUID().uuidString
		let ref = Storage.storage().reference(withPath: "/profile_image/\(filename).jpg")
		
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
