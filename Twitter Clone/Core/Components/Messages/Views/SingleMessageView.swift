//
//  SingleMessageView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 09/05/22.
//

import SwiftUI
import Firebase

struct SingleMessageView: View {
	
	var message: Message
	
    var body: some View {
		if let uid = Auth.auth().currentUser?.uid {
			HStack {
				if message.sender == uid {
					Spacer()
				}
				Text(message.body)
					.padding(10)
					.foregroundColor(message.sender == uid ? .primary : .white)
					.background(message.sender == uid ? .clear : Color("messageColor"))
					.overlay(RoundedRectangle(cornerRadius: 15)
								.stroke(lineWidth: 1)
								.foregroundColor(message.sender == uid ? .primary : .clear))
					.cornerRadius(15)
				if message.sender != uid {
					Spacer()
				}
			}
		}
    }
}
