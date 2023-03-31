//
//  Constants.swift
//  Starter Project
//
//  Created by Mahmoud Abdulwahab on 31/03/2023.
//

import Foundation

enum Constants {
    
    /// API KEY
    ///
    static var apiKey = ProcessInfo.processInfo.environment["API_KEY"]
    
    /// UNSPALSH URL
    ///
    static var unSplachEndPointURL = ProcessInfo.processInfo.environment["BASE_URL"]
}
