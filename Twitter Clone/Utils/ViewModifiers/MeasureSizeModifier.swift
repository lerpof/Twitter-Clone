//
//  MeasureSizeModifier.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 12/07/22.
//

import SwiftUI

struct MeasureSizeModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.background(GeometryReader { geometry in
            Color.clear.preference(key: SizePreferenceKey.self,
                                   value: geometry.size)
        })
    }
}
