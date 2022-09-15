//
//  BaseDataView.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 13/09/22.
//

import SwiftUI

struct BaseDataView<Content>: View where Content: View {
    
    @ObservedObject var baseDataViewModel: BaseDataViewModel
    private let content: Content
    
    public init(with viewModel: BaseDataViewModel, @ViewBuilder content: () -> Content) {
        self.baseDataViewModel = viewModel
        self.content = content()
    }
    
    var body: some View {
        Group {
            if baseDataViewModel.dataFetched {
                content
            } else {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .onAppear {
            baseDataViewModel.fetchData()
        }
    }
}
