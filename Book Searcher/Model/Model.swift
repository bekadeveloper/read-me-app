//
//  Book.swift
//  Book Searcher
//
//  Created by Begzod on 11/06/21.
//

import Foundation

struct Response: Decodable {
    var items: [Book]
    
    struct Book: Decodable, Identifiable {
        var id: String
        var volumeInfo: VolumeInfo
        
        struct VolumeInfo: Decodable {
            var title: String
            var authors: [String]?
            var publisher: String?
            var description: String?
            var imageLinks: ImageLinks?
            
            struct ImageLinks: Decodable {
                var smallThumbnail: String?
                var thumbnail: String?
            }
        }
    }
}
