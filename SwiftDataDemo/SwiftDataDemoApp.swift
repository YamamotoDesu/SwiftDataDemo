//
//  SwiftDataDemoApp.swift
//  SwiftDataDemo
//
//  Created by Yamamoto Kyo on 2024/01/20.
//

import SwiftUI

@main
struct SwiftDataDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: DataItem.self)
    }
}
