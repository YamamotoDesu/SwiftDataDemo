//
//  ItemDataSource.swift
//  SwiftDataDemo
//
//  Created by Yamamoto Kyo on 2024/01/20.
//

import Foundation
import SwiftData

final class ItemDataSource {
    private let container: ModelContainer
    private let context: ModelContext

    @MainActor
    static let shared = ItemDataSource()

    @MainActor
    private init() {
        self.container = try! ModelContainer(for: DataItem.self)
        self.context = container.mainContext
    }
    func fetchItems() -> [DataItem] {
        do {
            return try context.fetch(FetchDescriptor<DataItem>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func addItem() {
        let item = DataItem(name: "Test Item")
        context.insert(item)
        try? context.save()
    }
    
    func updateItem(_ item: DataItem) {
        item.name = "Updated Text Item"
        try? context.save()

    }
    
    func deleteItem(_ item: DataItem) {
        context.delete(item)
        try? context.save()
    }
}
