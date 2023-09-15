//
//  Networking.swift
//  summury
//
//  Created by Zuka Papuashvili on 15.09.23.
//

import Foundation

class Networking {
    
    static let shared = Networking()
    
//    func getData(completed: @escaping ([User]) -> Void) {
//
//        let urlString = "https://jsonplaceholder.typicode.com/users"
//        let url = URL(string: urlString)
//        let session = URLSession.shared
//
//        session.dataTask(with: url!) { data, response, error in
//
//            if let error = error {
//                print("Error: \(error)")
//            }
//
//            guard let httpResponse = response as? HTTPURLResponse,
//                  (200...299).contains(httpResponse.statusCode) else {
//                print("Invalid HTTP response")
//                return
//            }
//
//            guard let data = data else {
//                print("No Data Recieved!")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//
//                let users = try decoder.decode([User].self, from: data)
//
//                DispatchQueue.main.async {
//                    completed(users)
//                }
//                print(users)
//            } catch {
//                print("Error Decoding Json: \(error)")
//            }
//        }.resume()
//    }
    
    //MARK: - Refactored Fetching Call

    // Updated function with async/await
    func getData() async throws -> [User] {
        
        let urlString = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: urlString)!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let users = try decoder.decode([User].self, from: data)
        
        return users
    }
}


