//
//  ThumbnailCoverView.swift
//  Book Searcher
//
//  Created by Beka on 21/07/21.
//

import SwiftUI

struct ThumbnailCover: View {
    var bookThumbnail: UIImage?
    var width: CGFloat = 75
    
    var body: some View {
        if let thumbnail = bookThumbnail {
            Image(uiImage: thumbnail)
                .resizable()
                .aspectRatio(2/3, contentMode: .fit)
                .frame(width: width)
                .cornerRadius(7)
                .padding(.trailing)
        } else {
            Image(systemName: "text.book.closed.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .padding()
                .foregroundColor(.accentColor)
                .opacity(0.8)
        }
    }
}
