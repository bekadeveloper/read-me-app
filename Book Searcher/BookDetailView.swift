//
//  BookDetailView.swift
//  Book Searcher
//
//  Created by Begzod on 11/06/21.
//

import SwiftUI

struct BookDetailView: View {
    let book: Response.Book
    
    init(for book: Response.Book) {
        self.book = book
    }
    
    var bookThumbnail: UIImage {
        if let url = URL(string: book.volumeInfo.imageLinks.thumbnail) {
            do {
                let data = try Data(contentsOf: url)
                return UIImage(data: data) ?? UIImage()
            } catch  {
                print("something went wrong")
            }
        }
        return UIImage()
    }
    
    var body: some View {
        Form {
            HStack(alignment: .top, spacing: 20) {
                Image(uiImage: bookThumbnail)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)

                VStack(alignment: .leading) {
                    Text(book.volumeInfo.title).font(.title).bold()
                    Text(book.volumeInfo.authors?.first ?? "Unknown author")
                        .font(.body)

                }
            }
            .padding(.vertical)
            
            Section(header: Text("Description")) {
                Text(book.volumeInfo.description ?? "No description").font(.body)
            }
        }
    }
}
