//
//  Item.swift
//  8PuzzleApplication
//
//  Created by Ansar Shaikh on 12/9/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
