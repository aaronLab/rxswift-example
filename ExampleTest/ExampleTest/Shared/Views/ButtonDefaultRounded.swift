//
//  ButtonDefaultRounded.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import UIKit

class ButtonDefaultRounded: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 8.0
        backgroundColor = .orange
        setTitleColor(.white, for: .normal)
        setHeight(50.0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
