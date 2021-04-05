//
//  MainViewController.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Private Properties

    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    
    private let stack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = 16.0
        return s
    }()

    private lazy var buttonToPostListView: UIButton = {
        let btn = ButtonDefaultRounded(type: .system)
        btn.setTitle("Posts", for: .normal)
        btn.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return btn
    }()

    private lazy var buttonAlbumsListView: UIButton = {
        let btn = ButtonDefaultRounded(type: .system)
        btn.setTitle("Albums", for: .normal)
        btn.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        return btn
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Actions

    @objc private func buttonPressed(_ sender: UIButton) {

        if sender == buttonToPostListView {
            
            let vc = PostListViewController()
            navigationController?.pushViewController(vc, animated: true)
            
        }

        if sender == buttonAlbumsListView {
            print("Album List View")
        }

    }
    
    // MARK: - Helpers

    private func configureViews() {

        title = "MVVM Example"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .white
        
        // Scroll View
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.layoutIfNeeded()

        scrollView.addSubview(stack)
        stack.addArrangedSubview(buttonToPostListView)
        stack.addArrangedSubview(buttonAlbumsListView)
        
        stack.anchor(left: scrollView.leftAnchor,
            top: scrollView.topAnchor,
            right: scrollView.rightAnchor,
            bottom: scrollView.bottomAnchor,
            paddingLeft: 8,
            paddingTop: 8,
            paddingRight: 8,
            paddingBottom: 8)
        stack.setWidth(scrollView.frame.width - 16)
        stack.layoutIfNeeded()
        
        for _ in 0...20 {
            
            let testView = UIView()
            testView.backgroundColor = .gray
            testView.layer.cornerRadius = 8.0
            stack.addArrangedSubview(testView)
            testView.setDimensions(height: 50.0, width: stack.frame.size.width)
            
        }
        
    }

}
