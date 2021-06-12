//
//  ContentView.swift
//  Book Searcher
//
//  Created by Begzod on 11/06/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: BookData
    @State private var searchingText: String = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBarView(searchingText: $searchingText)
                    .padding(.horizontal, 10)
                
                List {
                    ForEach(viewModel.books) { book in
                        CellView(for: book)
                    }
                }
                .navigationBarTitle(Text("Books📚"))
                .listStyle(InsetListStyle())
                .onAppear { !searchingText.isEmpty ? viewModel.getBooks(containing: searchingText) : viewModel.getBooks() }
                .onChange(of: searchingText) { _ in
                    !searchingText.isEmpty ? viewModel.getBooks(containing: searchingText) : viewModel.getBooks()
                }
            }
        }
    }
}
