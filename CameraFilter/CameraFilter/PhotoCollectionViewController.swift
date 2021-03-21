//
//  PhotoCollectionViewController.swift
//  CameraFilter
//
//  Created by Aaron Lee on 2021/03/21.
//

import UIKit
import Photos

class PhotoCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populatePhotos()
    }
    
    private func populatePhotos() {
        
        PHPhotoLibrary.requestAuthorization { status in
            
            if status == .authorized {
                
                // access the photos from photo library
                
            }
            
        }
        
    }
    
}
