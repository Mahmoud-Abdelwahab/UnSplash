//
//  NetworkManager.swift
//  Starter Project
//
//  Created by Mahmoud Abdulwahab on 31/03/2023.
//

import Foundation

class NetworkManager {
    
   static var shared = NetworkManager()
    
   private init() { }
    
    func fetchImages(query: String, page: String) async throws -> [ImageURLResponse] {
        
        guard let request = Helpers.buildURLRequest(pageNumber: page) else {
            throw NetworkError.invalidUrl
        }
        let (data, response) = try await URLSession.shared.data(for: request)
        /// For any error throws invalidResponse
        ///
        if let response = response as? HTTPURLResponse,  !(200 ..< 300 ~= response.statusCode) {
            throw NetworkError.invalidResponse
        } else {
            return try Helpers.responseDecoder(data)
        }
    }
}

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
}
