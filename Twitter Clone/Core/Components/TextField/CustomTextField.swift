//
//  CustomTextField.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 26/04/22.
//

import SwiftUI

//enum TextFieldType {
//	case email
//	case password
//	case generic
//}

struct CustomTextField: View {
	let imageName: String?
	let	placeholderText: String
	
	var isSecureInput: Bool = false ///< define if this text field is secured and require eye button
	
	@State private var isSecured: Bool
	
	@Binding var text: String
	
	init(image: String? = nil,
		 placeholder: String,
		 text: Binding<String>,
		 isSecureInput: Bool) {
		imageName = image
		placeholderText = placeholder
		self._text = text
		self.isSecureInput = isSecureInput
		isSecured = isSecureInput
		
	}
	
	var body: some View {
		VStack {
			HStack {
				if let imageName = imageName {
					Image(systemName: imageName)
						.resizable()
						.scaledToFit()
						.frame(width: 25, height: 25)
						.foregroundColor(.primary.opacity(0.8))
				}
				
				if isSecureInput {
					Group {
						if isSecured {
							SecureField(placeholderText, text: $text)
						}
						else {
							TextField(text, text: $text)
						}
					}
					.disableAutocorrection(true)
					.autocapitalization(.none)
					.textContentType(.password)
					
					
					Button(action: {
						isSecured.toggle()
					}) {
						Image(systemName: self.isSecured ? "eye.slash" : "eye")
							.resizable()
							.scaledToFit()
							.frame(width: 25, height: 25)
							.foregroundColor(.primary.opacity(0.8))
					}
				}
				
				else {
					TextField(placeholderText, text: $text)
						.disableAutocorrection(true)
						.autocapitalization(.none)
				}
			}
			
			Divider()
		}
	}
}

struct CustomTextField_Previews: PreviewProvider {
	static var previews: some View {
		CustomTextField(image: "envelope", placeholder: "Email", text: .constant(""), isSecureInput: true)
			.previewLayout(.sizeThatFits)
	}
}
