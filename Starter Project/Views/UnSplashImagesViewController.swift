//
//  UnSplashImagesViewController.swift
//  Starter Project
//
//  Created by Ahmed M. Hassan on 26/03/2023.
//

import UIKit

class UnSplashImagesViewController: UIViewController {
  
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    private var photosScreenData = [ImageURLResponse]()
    private var currentPage = 0
    private var isPrefetchingEnabled = false

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }
}

// MARK: - Configurations

extension UnSplashImagesViewController {
    func configureViewController() {
        fetchLatestUnSplashImages()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.register(UnSplashImageTableViewCell.self, forCellReuseIdentifier: "UnSplachCell")
    }
}

// MARK: - Tabelview datasource & Prefetch datasource

extension UnSplashImagesViewController: UITableViewDataSource, UITableViewDelegate, UITableViewDataSourcePrefetching {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photosScreenData.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UnSplachCell", for: indexPath) as! UnSplashImageTableViewCell
        if let fullImageURL = photosScreenData[indexPath.row].urls?.small_s3 , let url = URL(string: fullImageURL) {
            cell.configure(with: url)
            return cell
        }
      
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UnSplashImageTableViewCell {
            let imageViewController = ImagePreviewViewController()
//            imageViewController.modalPresentationStyle = .fullScreen
            imageViewController.image = cell.splashImageView.image
            present(imageViewController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for index in indexPaths {
            if index.row >= (photosScreenData.count) - 4 && !isPrefetchingEnabled {
                fetchLatestUnSplashImages()
                break
            }
        }
    }
}

// MARK: - Private Handlers

private extension UnSplashImagesViewController {
    
    func fetchLatestUnSplashImages() {
        isPrefetchingEnabled = true
        Task {
            do {
                let photos = try await NetworkManager.shared.fetchImages(page: "\(currentPage)")
                reloadTableView(photos: photos)
            } catch {
                debugPrint( error.localizedDescription )
            }
        }
    }
    
  
    func reloadTableView(photos: [ImageURLResponse]) {
        DispatchQueue.main.async { [weak self] in
            self?.isPrefetchingEnabled = false
            self?.photosScreenData.append(contentsOf: photos)
            self?.currentPage += 1
            self?.tableView.reloadData()
        }
    }
}
