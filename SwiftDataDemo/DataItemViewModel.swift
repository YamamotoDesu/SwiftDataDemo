//
//  DataItemViewModel.swift
//  SwiftDataDemo
//
//  Created by Yamamoto Kyo on 2024/01/20.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class DataItemViewModel {
    @ObservationIgnored
    private let dataSource: ItemDataSource

    var items: [DataItem] = []
    
    init(dataSource: ItemDataSource = ItemDataSource.shared) {
        self.dataSource = dataSource
        items = dataSource.fetchItems()
    }

    func addItem() {
        dataSource.addItem()
        reloadItems()
    }
    
    func deleteItem(_ item: DataItem) {
        dataSource.deleteItem(item)
        reloadItems()
    }
    
    func updateItem(_ item: DataItem) {
        dataSource.updateItem(item)
        reloadItems()
    }
    
    private func reloadItems() {
        items = dataSource.fetchItems()
    }
}
