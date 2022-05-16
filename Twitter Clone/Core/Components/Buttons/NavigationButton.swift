//
//  NavigationButton.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 06/05/22.
//

import SwiftUI

struct NavigationButton<ButtonLabel: View, Destination: View>: View {
	
	private let buttonLabel: () -> ButtonLabel
	private let destination: () -> Destination
	@Binding var showNextView: Bool
	private let onDismiss: (() -> Void)?
	
	init(showNextView: Binding<Bool>,
		 label: @escaping(() -> ButtonLabel),
		 onDismiss: (() -> Void)? = nil,
		 destination: @escaping (() -> Destination)) {
		self._showNextView = showNextView
		self.onDismiss = onDismiss
		self.buttonLabel = label
		self.destination = destination
	}
	
	var body: some View {
		Button {
			showNextView.toggle()
		} label: {
			buttonLabel()
		}
		.navigationViewStyle(DefaultNavigationViewStyle())
		.fullScreenCover(isPresented: $showNextView, onDismiss: onDismiss, content: destination)
	}
}
