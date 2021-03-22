//
//  CollectionViewController.swift
//  CameraFilter
//
//  Created by Aaron Lee on 2021/03/22.
//

import UIKit
import Photos

private let cellIdentifier = "CellIdentifier"

class CollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
    private var images = [PHAsset]()
    
    lazy var closeBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.close,
                                        target: self,
                                        action: #selector(closeBarButtonPressed))
        return barButton
    }()
    
    // MARK: - Lifecycle
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        populatePhotos()
    }
    
    // MARK: - Actions
    
    @objc private func closeBarButtonPressed() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    
    /**
     Setup Views
     */
    private func configureViews() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = closeBarButton
    }
    
    /**
     Setup Photos
     */
    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            
            guard let `self` = self else { return }
            
            if status == .authorized {
                
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                
                assets.enumerateObjects { object, count, stop in
                    
                    self.images.append(object)
                    
                }
                
                self.images.reverse()
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }

            }

        }
    }
    
}
