//
//  NewsCell.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/03/24.
//

import UIKit

class NewsCell: UITableViewCell {
    
    // MARK: - Properties
    
    let labelTitle: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 17)
        lb.numberOfLines = 0
        return lb
    }()
    
    let labelDescription: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14)
        lb.textColor = .systemGray
        lb.numberOfLines = 0
        return lb
    }()
    
    // MARK: - Initialize
    
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
        stack.spacing = 8
        
        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelDescription)
        
        contentView.addSubview(stack)
        
        stack.anchor(
            left: contentView.leftAnchor,
            top: contentView.topAnchor,
            right: contentView.rightAnchor,
            bottom: contentView.bottomAnchor,
            paddingLeft: 8,
            paddingTop: 16,
            paddingRight: 8,
            paddingBottom: 16
        )
    }
    
}
