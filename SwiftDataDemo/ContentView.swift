//
//  ContentView.swift
//  SwiftDataDemo
//
//  Created by Yamamoto Kyo on 2024/01/20.
//

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
