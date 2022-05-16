//
//  SerchBarView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 02/05/22.
//

import SwiftUI

struct SearchBarView: View {
	
	@Binding var text: String
	
	var body: some View {
		VStack {
			HStack {
				Image(systemName: "magnifyingglass")
					.resizable()
					.scaledToFit()
					.frame(width: 25, height: 25)
					.foregroundColor(Color(.darkGray))
				
				TextField("Search...", text: $text)
					.disableAutocorrection(true)
					.autocapitalization(.none)
			}
			.padding(6)
		}
		.background(Color(.gray)
						.opacity(0.3))
		.clipShape(RoundedRectangle(cornerRadius: 10))
	}
}

struct SerchBarView_Previews: PreviewProvider {
    static var previews: some View {
		SearchBarView(text: .constant(""))
    }
}
