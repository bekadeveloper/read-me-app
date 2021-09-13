//
//  Book_SearcherApp.swift
//  Book Searcher
//
//  Created by Begzod on 11/06/21.
//

import SwiftUI

@main
struct ReadMeApp: App {
    let persistence = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistence.container.viewContext)
        }
    }
}
