//
//  TweetsView.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 25/04/22.
//

import SwiftUI

struct TweetsView: View {
	
	let filter: String
	
    var body: some View {
		ScrollView {
			LazyVStack {
				ForEach(0 ... 20, id: \.self) { _ in
					TweetRowView()
					Divider()
				}
			}
		}
    }
}

struct TweetsView_Previews: PreviewProvider {
    static var previews: some View {
		TweetsView(filter: "feed")
			.previewLayout(.sizeThatFits)
    }
}
