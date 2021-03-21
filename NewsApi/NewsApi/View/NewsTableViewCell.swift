//
//  NewsTableViewCell.swift
//  NewsApi
//
//  Created by Aaron Lee on 2021/03/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let labelTitle = UILabel()
    let labelDescription = UILabel()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setupViews() {
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.numberOfLines = 0
        labelTitle.textColor = .black
        
        labelDescription.numberOfLines = 0
        labelDescription.textColor = .darkGray
        labelDescription.font = .systemFont(ofSize: 14)
        labelDescription.setContentHuggingPriority(UILayoutPriority(rawValue: 252), for: .vertical)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelDescription)
        stack.layoutIfNeeded()

        contentView.addSubview(stack)
        stack.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor
        )
    }
    
}
