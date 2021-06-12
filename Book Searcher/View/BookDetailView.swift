//
//  BookDetailView.swift
//  Book Searcher
//
//  Created by Begzod on 11/06/21.
//

import SwiftUI

struct BookDetailView: View {
    let book: Response.Book
    let bookThumbnail: UIImage?
    
    init(for book: Response.Book, image: UIImage?) {
        self.book = book
        bookThumbnail = image
    }
    
    var body: some View {
        Form {
            HStack(alignment: .top) {
                Image(uiImage: bookThumbnail ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 125)
                    .cornerRadius(7)

                VStack(alignment: .leading) {
                    Text(book.volumeInfo.title).font(.title2).bold()
                    Text(book.volumeInfo.authors?.first ?? "Unknown Author").font(.body)
                }
            }
            .padding(.vertical)
            
            Section(header: Text("Publisher")) {
                Text(book.volumeInfo.publisher ?? "Unknown Publisher")
            }
            
            Section(header: Text("Description")) {
                Text(book.volumeInfo.description ?? "No Description").font(.body)
            }
        }
    }
}
