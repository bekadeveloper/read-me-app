//
//  Book.swift
//  Book Searcher
//
//  Created by Begzod on 11/06/21.
//

import Foundation

struct Response: Decodable {
//    var kind: String
//    var totalItems: Int
    var items: [Book]
    
    struct Book: Decodable, Identifiable {
        var id: String
        var volumeInfo: VolumeInfo
        
        struct VolumeInfo: Decodable {
            var title: String
//            var authors: [String]
//            var publisher: String
//            var description: String
            var imageLinks: ImageLinks
            
            struct ImageLinks: Decodable {
                var smallThumbnail: String
                var thumbnail: String
            }
        }
    }
}

class BookData: ObservableObject {
    @Published var books: [Response.Book] = []
    
    
    func getBooks() {
            guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=programming") else { fatalError("Missing URL") }

            let urlRequest = URLRequest(url: url)

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }

                if response.statusCode == 200 {
                    guard let data = data else { return }
//                    print(String(data: data, encoding: .utf8)!)
                    
                    DispatchQueue.main.async {
                        do {
                            let decodedResponse = try JSONDecoder().decode(Response.self, from: data)
                            self.books = decodedResponse.items
                        } catch let error {
                            print("Error decoding: ", error)
                        }
                    }
                }
            }
            dataTask.resume()
        }
}
