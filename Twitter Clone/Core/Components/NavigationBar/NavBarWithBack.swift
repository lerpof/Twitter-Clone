//
//  NavBarWithBack.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 07/05/22.
//

import SwiftUI

struct NavBarWithBack<Title: View>: View {
	
	let title: Title
	@Environment(\.presentationMode) var presentationMode
	
	init(title: ()->Title) {
		self.title = title()
	}
	
    var body: some View {
		NavigationBar {
			Button {
				presentationMode.wrappedValue.dismiss()
			} label: {
				Image(systemName: "arrow.left")
					.resizable()
					.frame(width: 15, height: 15)
					.foregroundColor(.primary)
			}
		} titleView: {
			title
				.font(.headline)
		} trailingView: {
			Spacer()
				.frame(width: 15, height: 15)
		}
    }
}

struct NavBarWithBack_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			NavBarWithBack {
				Text("CIAO")
			}
			Spacer()
		}
    }
}
