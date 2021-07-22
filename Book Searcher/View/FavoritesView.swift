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
        List {
            Button("Add") {
                let book = Book(context: viewContext)
                book.id = UUID()
                book.title = "Book no. \(book.id!.uuidString.first!)"
                try? viewContext.save()
            }
            ForEach(books) { book in
                Text(book.title ?? "unknown")
            }
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
