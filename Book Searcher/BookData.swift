//
//  BookData.swift
//  Book Searcher
//
//  Created by Begzod on 12/06/21.
//

import Foundation

class BookData: ObservableObject {
    
    @Published var books: [Response.Book] = []
    
    
    func getBooks(containing text: String = "programming") {
        guard let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(text.replacingOccurrences(of: " ", with: "%20"))") else { fatalError("Missing URL") }

            let urlRequest = URLRequest(url: url)

            let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    print("Request error: ", error)
                    return
                }

                guard let response = response as? HTTPURLResponse else { return }

                if response.statusCode == 200 {
                    guard let data = data else { return }
                    
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
