//
//  ContentView.swift
//  Book Searcher
//
//  Created by Beka on 22/07/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    let data = BookData()
    
    var body: some View {
        TabView {
            FinderView(viewModel: data)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
            FavoritesView()
                .tabItem {
                    Image(systemName: "bookmark.fill")
                }
        }
        .environment(\.managedObjectContext, viewContext)
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
