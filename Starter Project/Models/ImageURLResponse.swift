//
//  ImageURLResponse.swift
//  Starter Project
//
//  Created by Mahmoud Abdulwahab on 31/03/2023.
//

import Foundation

// MARK: - ImageURLResponse
struct ImageURLResponse: Decodable {
    let urls: Urls?
}

// MARK: - Urls
struct Urls: Decodable {
    let small_s3: String?
}
