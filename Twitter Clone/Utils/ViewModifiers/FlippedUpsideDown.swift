//
//  FlippedUpsideDown.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 11/05/22.
//

import SwiftUI

struct FlippedUpsideDown: ViewModifier {
	func body(content: Content) -> some View {
		content
			.rotationEffect(Angle.degrees(180))
			.scaleEffect(x: -1, y: 1, anchor: .center)
	}
}
