//
//  BaseDataViewModel.swift
//  Twitter Clone
//
//  Created by Leonardo Lazzari on 13/09/22.
//

import Foundation

class BaseDataViewModel: ObservableObject {
    
    @Published var dataFetched = false
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        fatalError("updateData() has not been implemented")
    }
    
}
