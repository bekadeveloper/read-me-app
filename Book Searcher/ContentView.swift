//
//  ContentView.swift
//  Book Searcher
//
//  Created by Begzod on 11/06/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: BookData
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.books) { book in
                    Text(book.volumeInfo.title)
                }
            }
            .navigationBarTitle(Text("Books📚"))
            .listStyle(SidebarListStyle())
            .onAppear { viewModel.getBooks() }
        }
    }
}
