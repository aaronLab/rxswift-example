//
//  PhotoCollectionViewController.swift
//  CameraFilter
//
//  Created by Aaron Lee on 2021/03/21.
//

import UIKit
import Photos

private let cellIdentifier = "PhotoCollectionViewCell"

class PhotoCollectionViewController: UICollectionViewController {
    
    private var images = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    private func populatePhotos() {
        
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            
            guard let `self` = self else { return }
            
            if status == .authorized {
                
                // access the photos from photo library
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

// MARK: - UICollectionViewDataSource

extension PhotoCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("PhotoCollectionViewCell is not found")
        }
        
        let asset = self.images[indexPath.row]
        let manager = PHImageManager.default()
        manager.requestImage(for: asset,
                             targetSize: CGSize(width: 100, height: 100),
                             contentMode: .aspectFit,
                             options: nil) { image, _ in
            
            DispatchQueue.main.async {
                cell.photoImageView.image = image
            }
            
        }
        
        return cell
    }
    
}
