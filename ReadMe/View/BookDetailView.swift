//
//  BookDetailView.swift
//  Book Searcher
//
//  Created by Begzod on 11/06/21.
//

import SwiftUI

struct BookDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
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
                        Text(book.volumeInfo.authors?.first ?? "Unknown author(s)")
                    }
                }
                .padding(.vertical)
                
                Section(header: Text("Publisher")) {
                    Text(book.volumeInfo.publisher ?? "Unknown publisher")
                }
                
                Section(header: Text("Description")) {
                    Text(book.volumeInfo.description ?? "No description")
                }
            }
            
            VStack {
                Spacer()
                Button(action: addBookToShelf) {
                    LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 0.6984999776, blue: 0.5462449789, alpha: 1)), Color(#colorLiteral(red: 0.9960784314, green: 0.266684562, blue: 0.3067400753, alpha: 0.9506674255))]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .frame(width: 330, height: 50)
                        .cornerRadius(20)
                        .overlay {
                            Text("Add to the shelf")
                                .foregroundColor(.white)
                                .font(.system(size: 22, weight: .semibold, design: .rounded))
                        }
                }
                .padding(.bottom, 20)
            }
        }
    }
    
    private func addBookToShelf() {
        let newBook = Book(context: viewContext)
        
        newBook.stringID = book.id
        newBook.title = book.volumeInfo.title
        newBook.author = book.volumeInfo.authors?[0]
        newBook.descript = book.volumeInfo.description
        newBook.publisher = book.volumeInfo.publisher
        newBook.thumbnail = bookThumbnail?.pngData()
        
        try? viewContext.save()
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(for: Response.Book(id: UUID().uuidString, volumeInfo: Response.Book.VolumeInfo(title: "Placeholder")))
    }
}
