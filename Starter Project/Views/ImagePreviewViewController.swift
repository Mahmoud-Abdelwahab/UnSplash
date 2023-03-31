//
//  ImagePreviewViewController.swift
//  Starter Project
//
//  Created by Mahmoud Abdulwahab on 31/03/2023.
//

import UIKit

class ImagePreviewViewController: UIViewController {
    
    // MARK: Properties

   private let imageView = UIImageView()
   var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
}


// MARK: - Configurations

private extension ImagePreviewViewController {
    func configureViewController() {
        view.backgroundColor = .gray
        setupImageViewConstrains()
    }
    
    func setupImageViewConstrains() {
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        imageView.image = image
    }
}
