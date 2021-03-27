//
//  NewsTableViewCell.swift
//  News
//
//  Created by Aaron Lee on 2021/03/27.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    let labelTitle: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        return lb
    }()
    
    let labelDescription: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 14)
        lb.textColor = .gray
        lb.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        return lb
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureCell() {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8.0
        
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelDescription)
        
        contentView.addSubview(stack)
        stack.anchor(left: contentView.leftAnchor,
                     top: contentView.topAnchor,
                     right: contentView.rightAnchor,
                     bottom: contentView.bottomAnchor,
                     paddingLeft: 8,
                     paddingTop: 8,
                     paddingRight: 8,
                     paddingBottom: 8)
    }
    
}
