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
    let activityIndicatore = UIActivityIndicatorView()
    
    // MARK: Init
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with imageURL: URL) {
        activityIndicatore.startAnimating()
        DispatchQueue.global().async {
            let image =  UIImage(url: imageURL)
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.splashImageView.image = image
                self.activityIndicatore.stopAnimating()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViewConstrains()
        setupActivityIndicator()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        splashImageView.image = nil
    }
    
    private func setupViewConstrains() {
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
    
    private func setupActivityIndicator() {
        splashImageView.addSubview(activityIndicatore)
        activityIndicatore.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatore.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicatore.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityIndicatore.heightAnchor.constraint(equalToConstant: 80),
            activityIndicatore.widthAnchor.constraint(equalToConstant: 80)
        ])
        activityIndicatore.color = UIColor.black
    }
}
