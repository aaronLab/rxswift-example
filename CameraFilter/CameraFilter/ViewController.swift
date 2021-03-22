//
//  ViewController.swift
//  CameraFilter
//
//  Created by Aaron Lee on 2021/03/22.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var addBarButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add,
                                        target: self,
                                        action: #selector(addBarButtonPressed))
        return barButton
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        return iv
    }()
    
    lazy var filterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Apply Filter", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: - Actions
    
    /// Show photo collection view
    @objc private func addBarButtonPressed() {
        let vc = CollectionViewController()
        let nvc = UINavigationController(rootViewController: vc)
        nvc.modalPresentationStyle = .fullScreen
        present(nvc, animated: true)
    }
    
    // MARK: - Helpers
    
    private func configureView() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = addBarButton
        title = "Camera Filter"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Image View
        view.addSubview(imageView)
        imageView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            right: view.rightAnchor
        )
        imageView.setHeight(view.frame.size.height * 0.75)
        
        // Filter Button
        view.addSubview(filterButton)
        filterButton.anchor(
            top: imageView.bottomAnchor,
            paddingTop: 8
        )
        filterButton.centerX(inView: view)
        filterButton.setWidth(120)
        filterButton.isHidden = true
    }

}

