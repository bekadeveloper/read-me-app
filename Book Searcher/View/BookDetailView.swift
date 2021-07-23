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
    
    init(for book: Response.Book, image: UIImage? = nil) {
        self.book = book
        bookThumbnail = image
    }
    
    var body: some View {
        ZStack {
            Form {
                HStack(alignment: .top) {
                    ThumbnailCover(bookThumbnail: bookThumbnail, width: 95)

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
            
            VStack {
                Spacer()
                Button(action: {} ) {
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.6984999776, blue: 0.5462449789, alpha: 1)), Color(#colorLiteral(red: 0.9946357608, green: 0.266684562, blue: 0.3067400753, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 330, height: 50)
                        .cornerRadius(20)
                        .overlay {
                            Text("Add to the shelf")
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .regular, design: .default))
                        }
                }
                .padding(.bottom, 20)
            }
        }
//        .edgesIgnoringSafeArea(.all)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(for: Response.Book(id: UUID().uuidString, volumeInfo: Response.Book.VolumeInfo(title: "Placeholder")))
    }
}
