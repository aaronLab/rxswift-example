//
//  PhotosCollectionViewController.swift
//  Camera Filter
//
//  Created by Aaron Lee on 2020-10-11.
//

import UIKit
import Photos

class PhotosCollectionViewController: UICollectionViewController {
    
    private var images = [PHAsset]()

    override func viewDidLoad() {
        super.viewDidLoad()

        populatePhotos()
    }

    private func populatePhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            
            if status == .authorized {
                
                // Access the photos from photo library
                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                
                assets.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                
                self?.images.reverse()
                self?.collectionView.reloadData()
                
            }
            
        }
    }

}
