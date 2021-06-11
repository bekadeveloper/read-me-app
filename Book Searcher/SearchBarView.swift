//
//  SearchBarView.swift
//  Book Searcher
//
//  Created by Begzod on 11/06/21.
//

import SwiftUI

struct SearchBarView: View {
    @Binding var searchingText: String
    @State private var isEditing: Bool = false
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search book", text: $searchingText)
                    .onTapGesture {
                        withAnimation {
                            isEditing = true
                        }
                    }
            }
            .padding(10)
            .background(Color.secondary.opacity(0.2))
            .cornerRadius(10)
            
            if isEditing {
                Button("Cancel") {
                    searchingText = ""
                    isEditing = false
                }
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchingText: .constant(""))
    }
}
