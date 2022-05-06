//
//  SideBarStack.swift
//  Twitter Clone
//
//  Created by CGMCONSULTING on 06/05/22.
//

import SwiftUI

struct SideBarStack<SidebarContent: View, Content: View>: View {
	
	let sidebarContent: SidebarContent
	let mainContent: Content
	let sideMenuWidth: CGFloat
	@Binding var offset: Double
	
	init(sidebarWidth: CGFloat, offset: Binding<Double>, @ViewBuilder sidebar: ()->SidebarContent, @ViewBuilder content: ()->Content) {
		self.sideMenuWidth = sidebarWidth
		self._offset = offset
		sidebarContent = sidebar()
		mainContent = content()
	}
	
	var body: some View {
		ZStack(alignment: .leading) {
			sidebarContent
				.frame(width: sideMenuWidth)
				.offset(x: offset - sideMenuWidth)
				.animation(.easeInOut, value: offset)
			mainContent
				.overlay(
					Rectangle()
						.fill(
							Color.primary.opacity(Double((offset / sideMenuWidth) * 0.4))
						)
						.ignoresSafeArea(.container, edges: .vertical)
						.onTapGesture {
							withAnimation {
								offset = 0
							}
						}
				)
				.offset(x: offset)
				.animation(.easeInOut, value: offset)
				
		}
		.gesture(
			DragGesture()
				.onChanged({ value in
					onChanged(newValue: value.translation.width)
				})
				.onEnded({ value in
					onEnded(endValue: value.translation.width)
				})
		)
		.animation(.easeInOut, value: offset)
	}
}

// MARK: - Extension for support func
extension SideBarStack {
	
	
	/// Function that handle the change of dragGesture inside screen.
	/// Don't allow value under 0 or over sideMenuWith to prevent too much offset inside screen
	/// - Parameter changedGestureOffset: actual value of gesture offset
	private func onChanged(newValue changedGestureOffset: CGFloat) {
		if changedGestureOffset > 0 && offset < sideMenuWidth {
			if changedGestureOffset <= sideMenuWidth {
				offset = changedGestureOffset
			}
		} else if changedGestureOffset < 0 && offset > 0 {
			if changedGestureOffset >= -sideMenuWidth {
				offset = sideMenuWidth + changedGestureOffset
			}
		}
	}
	
	
	/// Function that handle the endof dragGesture value.
	/// When gesture is over half of sideMenuWith consider the gesture as completed.
	/// - Parameter endedGestureOffset: ended value of gesture offset
	private func onEnded(endValue endedGestureOffset: CGFloat) {
		if endedGestureOffset > 0 && offset < sideMenuWidth {
			if endedGestureOffset >= sideMenuWidth / 2 {
				offset = sideMenuWidth
			} else {
				offset = 0
			}
		} else if endedGestureOffset < 0 && offset > 0 {
			if endedGestureOffset <=  -sideMenuWidth / 2 {
				offset = 0
			} else {
				offset = sideMenuWidth
			}
		}
	}
}

