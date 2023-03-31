//
//  UIImage+Extension.swift
//  Starter Project
//
//  Created by Mahmoud Abdulwahab on 31/03/2023.
//

import UIKit

extension UIImage {
    convenience init?(url: URL) {
        do {
            let imageData = try Data(contentsOf: url)
            self.init(data: imageData)
        } catch {
            print("Error loading image from URL: \(error)")
            return nil
        }
    }
}
