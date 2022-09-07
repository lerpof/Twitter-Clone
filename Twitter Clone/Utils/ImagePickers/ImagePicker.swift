//
//  ImagePicker.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 28/04/22.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
	@Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    let shouldEdit: Bool

	func makeUIViewController(context: Context) -> some UIViewController {
		let picker = UIImagePickerController()
        picker.allowsEditing = shouldEdit
		picker.delegate = context.coordinator
		return picker
	}

	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {

	}

	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
}

extension ImagePicker {
	class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
		let parent: ImagePicker

		init(_ parent: ImagePicker) {
			self.parent = parent
		}
		
		func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let image = (parent.shouldEdit ? info[.editedImage] : info[.originalImage]) as? UIImage else { return }
            parent.image = image
            parent.presentationMode.wrappedValue.dismiss()
		}

		
	}
}
