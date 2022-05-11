//
//  NavigationBar.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 06/05/22.
//

import SwiftUI

struct NavigationBar<Leading: View, Title: View, Trailing: View>: View {
	
	private let leadingView: () -> Leading
	private let titleView: () -> Title
	private let trailingView: () -> Trailing
	
	init(leadingView: @escaping(() -> Leading),
		 titleView: @escaping(() -> Title),
		 trailingView: @escaping(() -> Trailing)) {
		self.leadingView = leadingView
		self.titleView = titleView
		self.trailingView = trailingView
	}
	
    var body: some View {
		HStack(alignment: .center) {
			HStack {
				leadingView()
				Spacer()
				titleView()
				Spacer()
				trailingView()
			}
			.padding()
		}
		.background(Color.secondary.opacity(0.3))
		.frame(height: 45)
    }
}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			
			Spacer()
		}
    }
}
