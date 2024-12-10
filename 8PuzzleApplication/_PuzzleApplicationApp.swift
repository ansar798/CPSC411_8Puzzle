//
//  _PuzzleApplicationApp.swift
//  8PuzzleApplication
//
//  Created by Ansar Shaikh on 12/9/24.
//

import SwiftUI
import SwiftData

@main
struct _PuzzleApplicationApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .background(Color("BrownBackground"))
                .edgesIgnoringSafeArea(.all)
        }
        .modelContainer(sharedModelContainer)
    }
}
