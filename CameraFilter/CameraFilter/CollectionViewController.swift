//
//  CollectionViewController.swift
//  CameraFilter
//
//  Created by Aaron Lee on 2021/03/22.
//

import UIKit

private let cellIdentifier = "CellIdentifier"

class CollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    
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
    }
    
    // MARK: - Actions
    
    @objc private func closeBarButtonPressed() {
        dismiss(animated: true)
    }
    
    // MARK: - Helpers
    
    private func configureViews() {
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = closeBarButton
    }
    
}
