//
//  Helpers.swift
//  Starter Project
//
//  Created by Mahmoud Abdulwahab on 31/03/2023.
//

import UIKit

enum Helpers {
    
   static func responseDecoder(_ responseData: Data) throws ->  [ImageURLResponse] {
        let decoder = JSONDecoder()
        let response = try decoder.decode([ImageURLResponse].self, from: responseData)
        return response
    }
    
    static func buildURLRequest(pageNumber: String) -> URLRequest? {
        let parameters = [ "page": pageNumber,
                          "client_id": Constants.apiKey ]
        var components = URLComponents(string: Constants.unSplachEndPointURL ?? "")
        components?.queryItems = parameters.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        guard let url = components?.url else { return nil }
        let request = URLRequest(url: url)
        return request
    }
    
    static func loadFrom(url: String) async throws -> UIImage? {
        guard let url = URL(string: url) else { return nil }
        let (data, _) = try await URLSession.shared.data(from: url)
        return UIImage(data: data)
    }
}
