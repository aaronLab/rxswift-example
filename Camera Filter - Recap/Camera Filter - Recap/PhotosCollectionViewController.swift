//
//  PhotosCollectionViewCell.swift
//  Camera Filter - Recap
//
//  Created by Aaron Lee on 2020-10-11.
//

import UIKit
import Photos
import RxSwift

class PhotosCollectionViewController: UICollectionViewController {

    private let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }

    private var photos = [PHAsset]()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }

    private func updateUI() {

        PHPhotoLibrary.requestAuthorization { [weak self] status in

            if status == .authorized {

                let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)

                assets.enumerateObjects { (object, count, stop) in
                    self?.photos.append(object)
                }

                self?.photos.reverse()

                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }

            }

        }

    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PhotoCollectionViewCell else { fatalError("Cell Not Found") }

        let asset = self.photos[indexPath.row]
        let manager = PHImageManager.default()

        manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { img, _ in

            DispatchQueue.main.async {
                cell.imgView.image = img
            }

        }

        return cell

    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedAsset = photos[indexPath.row]
        
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] (img, info) in
            
            guard let info = info else { return }
            
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            
            if !isDegradedImage {
                
                if let img = img {
                    
                    self?.selectedPhotoSubject.onNext(img)
                    self?.dismiss(animated: true, completion: nil)
                    
                }
                
            }
            
        }
        
    }

}
