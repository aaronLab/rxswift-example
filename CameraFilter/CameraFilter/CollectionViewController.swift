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
        
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let horizontalSpacing = flowLayout.scrollDirection == .vertical ? flowLayout.minimumInteritemSpacing : flowLayout.minimumLineSpacing
            let cellWidth = (collectionView.frame.width - max(0, 3 - 1)*horizontalSpacing)/3
            flowLayout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        }
        
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

// MARK: - DataSource

extension CollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CollectionViewCell else {
            fatalError("CollectionViewCell is not found")
        }
        
        let numInRow: CGFloat = 3
        let margins: CGFloat = 8 * (numInRow - 1)
        let width: CGFloat = (view.frame.width / numInRow) - margins
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: width, height: width),
                             contentMode: .aspectFit,
                             options: nil) { image, _ in
            
            DispatchQueue.main.async {
                cell.imageView.image = image
            }
            
        }
        return cell
    }
    
}
