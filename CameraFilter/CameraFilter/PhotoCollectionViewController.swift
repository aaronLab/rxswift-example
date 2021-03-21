//
//  PhotoCollectionViewController.swift
//  CameraFilter
//
//  Created by Aaron Lee on 2021/03/21.
//

import UIKit
import Photos

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
                
                self.collectionView.reloadData()
                
            }
            
        }
        
    }
    
}
