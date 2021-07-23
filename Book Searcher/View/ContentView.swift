//
//  ContentView.swift
//  Book Searcher
//
//  Created by Beka on 22/07/21.
//

import SwiftUI

struct ContentView: View {
    let data = BookData()
    
    var body: some View {
        TabView {
            FinderView(viewModel: data)
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }
                .statusBar(hidden: true)
            FavoritesView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
