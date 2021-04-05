//
//  PostListViewCell.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import UIKit

class PostListViewCell: UITableViewCell {

    let labelTitle: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 17, weight: .semibold)
        return lb
    }()

    let labelBody: UILabel = {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 14)
        lb.textColor = .gray
        lb.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        return lb
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8.0

        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelBody)

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

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
