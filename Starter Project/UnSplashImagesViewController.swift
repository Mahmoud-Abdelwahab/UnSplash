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
    
    private var photosScreenData: [ImageURLResponse]?
    private var currentPage = 0
    
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
        tableView.prefetchDataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UnSplachCell")
    }
}

// MARK: - Tabelview datasource & Prefetch datasource

extension UnSplashImagesViewController: UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photosScreenData?.count ?? .zero
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UnSplachCell", for: indexPath)
        if let thumb = photosScreenData?[indexPath.row].urls?.thumb , let url = URL(string: thumb) {
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // Load data for the next page
        currentPage = indexPaths.last!.row + 1
        fetchLatestUnSplashImages()
    }
    
}

// MARK: - Private Handlers

private extension UnSplashImagesViewController {
    
    func fetchLatestUnSplashImages() {
        Task {
            do {
                let photos = try await NetworkManager.shared.fetchImages(page: "\(currentPage)")
                reloadTableView(photos: photos)
            } catch {
                debugPrint( error.localizedDescription )
            }
        }
    }
    
    @MainActor
    func reloadTableView(photos: [ImageURLResponse]) {
        photosScreenData = photos
        tableView.reloadData()
    }
}
