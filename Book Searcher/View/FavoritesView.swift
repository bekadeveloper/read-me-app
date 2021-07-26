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
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 110))]) {
                    ForEach(books, id: \.stringID) { book in
                        SubView(book: book)
                            .contextMenu {
                                Text("Placeholder 1")
                                Text("Placeholder 2")
                                Button(action: { delete(book) }) {
                                    Label("Remove", systemImage: "trash.fill")
                                }
                            }
                    }
                }
                .navigationBarTitle(Text("Saved Books"))
                .toolbar(content: { EditButton() })
                .padding(10)
            }
        }
    }
    
    private func delete(_ book: Book) {
        if let chosenBook =  books.first(where: { $0.stringID == book.stringID }) {
            withAnimation {
                viewContext.delete(chosenBook)
                try? viewContext.save()
            }
        }
    }
    
    private func deleteUsingIndexSet(_ offset: IndexSet) {
        offset.map { books[$0] }.forEach { viewContext.delete($0) }
        try? viewContext.save()
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}


struct SubView: View {
    let book: Book
    
    var body: some View {
        Group {
            if let imgData = book.thumbnail {
                Image(uiImage: UIImage(data: imgData)!)
                    .resizable()
            } else {
                ZStack(alignment: .top) {
                    Rectangle()
                        .foregroundColor(.accentColor)
                        .opacity(0.8)
                    Text(book.title ?? "Unknown title")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                }
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .frame(width: 120)
        .aspectRatio(2/3, contentMode: .fit)
    }
}
