//
//  CollectionViewCell.swift
//  CameraFilter
//
//  Created by Aaron Lee on 2021/03/22.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
}
