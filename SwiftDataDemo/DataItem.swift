//
//  DataItem.swift
//  SwiftDataDemo
//
//  Created by Yamamoto Kyo on 2024/01/20.
//

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

