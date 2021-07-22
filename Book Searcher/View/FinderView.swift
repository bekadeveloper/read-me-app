//
//  FinderView.swift
//  Book Searcher
//
//  Created by Begzod on 11/06/21.
//

import SwiftUI
import SwiftUIX

struct FinderView: View {
    @ObservedObject var viewModel: BookData
    @State private var searchingText: String = ""
    @State var isEditing: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar("Search...", text: $searchingText, isEditing: $isEditing)
                    .showsCancelButton(isEditing)
                    .onCancel { searchingText = "" }
                
                List {
                    ForEach(viewModel.books) { book in
                        CellView(for: book)
                    }
                }
                .navigationTitle(Text("Books📚"))
                .listStyle(InsetListStyle())
                .onAppear { !searchingText.isEmpty ? viewModel.getBooks(containing: searchingText) : viewModel.getBooks() }
                .onChange(of: searchingText) { _ in
                    !searchingText.isEmpty ? viewModel.getBooks(containing: searchingText) : viewModel.getBooks()
                }
            }
        }
    }
}
