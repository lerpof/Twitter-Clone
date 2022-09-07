//
//  SizePreferenceKey.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 12/07/22.
//

import SwiftUI

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}
