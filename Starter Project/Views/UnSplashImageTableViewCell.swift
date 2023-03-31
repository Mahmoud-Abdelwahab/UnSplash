//
//  UnSplashImageTableViewCell.swift
//  Starter Project
//
//  Created by Mahmoud Abdulwahab on 31/03/2023.
//

import UIKit

class UnSplashImageTableViewCell: UITableViewCell {
    
    // MARK: Properties

    let splashImageView = UIImageView()
    
    // MARK: Init

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageURL: URL) {
        DispatchQueue.global().async {
            let image =  UIImage(url: imageURL)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.splashImageView.image = image
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        splashImageView.contentMode = .scaleToFill
        splashImageView.clipsToBounds = true
        contentView.addSubview(splashImageView)
        splashImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            splashImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            splashImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            splashImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            splashImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            splashImageView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}
