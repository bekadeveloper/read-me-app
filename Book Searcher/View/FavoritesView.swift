//
//  FavoritesView.swift
//  Book Searcher
//
//  Created by Beka on 22/07/21.
//

import SwiftUI

struct FavoritesView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true)])
    private var books: FetchedResults<Book>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.stringID) { book in
                    Text(book.title ?? "unknown")
                }
                .onDelete(perform: deleteBooksFromShelf)
            }
            .navigationBarTitle(Text("Saved Books"))
            .listStyle(SidebarListStyle())
            .toolbar(content: { EditButton() })
        }
    }
    
    private func deleteBooksFromShelf(_ offset: IndexSet) {
        offset.map { books[$0] }.forEach { viewContext.delete($0) }
        try? viewContext.save()
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
