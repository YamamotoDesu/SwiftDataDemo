<img width="300" alt="image" src="https://github.com/YamamotoDesu/SwiftDataDemo/assets/47273077/c345e504-0112-4431-9849-5611f70cc6ad">

# [SwiftData Basics](https://www.youtube.com/watch?v=krRkm8w22A8)
Model
```swift
import Foundation
import SwiftData

@Model
class DataItem: Identifiable {
    
    var id: String
    var name: String
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
}
```

App
```swift
    WindowGroup {
            ContentView()
        }
        .modelContainer(for: DataItem.self)
```


ContentView
```swift
import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var items: [DataItem]
    
    var body: some View {
        VStack {
            Text("Tap on this button to add data")
            Button("Add an item") {
                addItem()
            }
            
            List {
                ForEach (items) { item in
                    
                    HStack {
                        Text(item.name)
                        Spacer()
                        Button {
                            updateItem(item)
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        deleteItem(items[index])
                    }
                }
            }
        }
        .padding()
    }
    
    func addItem() {
        let item = DataItem(name: "Test Item")
        context.insert(item)
    }
    
    func deleteItem(_ item: DataItem) {
        context.delete(item)
    }
    
    func updateItem(_ item: DataItem) {
        item.name = "Updated Text Item"
        
        try? context.save()
    }
}
```


## [Splitting SwiftData and SwiftUI via MVVM](https://dev.to/jameson/swiftui-with-swiftdata-through-repository-36d1)

App
```swift
@main
struct SwiftDataDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
```

View
```swift
import SwiftUI
import SwiftData

struct ContentView: View {
    
    @State private var viewModel = DataItemViewModel()

    var body: some View {
        VStack {
            Text("Tap on this button to add data")
            Button("Add an item") {
                viewModel.addItem()
            }
            
            List {
                ForEach (viewModel.items) { item in
                    
                    HStack {
                        Text(item.name)
                        Spacer()
                        Button {
                            viewModel.updateItem(item)
                        } label: {
                            Image(systemName: "arrow.triangle.2.circlepath")
                        }
                    }
                }
                .onDelete { indexes in
                    for index in indexes {
                        viewModel.deleteItem(viewModel.items[index])
                    }
                }
            }
        }
        .padding()
    }
}
```

ViewModel
```swift

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

```

DataSource
```swift
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
```
