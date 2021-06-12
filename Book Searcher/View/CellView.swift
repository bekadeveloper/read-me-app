//
//  CellView.swift
//  Book Searcher
//
//  Created by Begzod on 12/06/21.
//

import SwiftUI

struct CellView: View {
    let book: Response.Book
    
    init(for book: Response.Book) {
        self.book = book
    }
    
    @State private var bookThumbnail: UIImage?
    
    var body: some View {
        NavigationLink(destination: BookDetailView(for: book, image: bookThumbnail)) {
            LazyHStack(alignment: .top) {
                Image(uiImage: bookThumbnail ?? UIImage())
                    .resizable()
                    .aspectRatio(2/3, contentMode: .fit)
                    .frame(width: 75)
                    .foregroundColor(.secondary)
                    .cornerRadius(7)
                    .padding(.trailing)
                
                LazyVStack(alignment: .leading) {
                    Text(book.volumeInfo.title).font(.headline)
                    
                    if let authors = book.volumeInfo.authors {
                        ForEach(authors, id: \.self){ author in
                            Text(author).font(.subheadline)
                        }
                    }
                }
                .frame(width: 225)
            }
            .onAppear { loadBookThumbnail() }
        }
    }
    
    private func loadBookThumbnail() {
        if let stringUrl = book.volumeInfo.imageLinks?.thumbnail {
            if let url = URL(string: stringUrl) {
                
                DispatchQueue.global().async {
                    do {
                        let data = try Data(contentsOf: url)
                        DispatchQueue.main.async {
                            bookThumbnail = UIImage(data: data)
                        }
                    } catch {
                        print("No image data")
                    }
                }
            } else {
                print("Missing URL")
            }
        }
    }
}
