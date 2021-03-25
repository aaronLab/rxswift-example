//
//  CustomTextField.swift
//  Weather
//
//  Created by Aaron Lee on 2021/03/25.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String) {
        super.init(frame: .zero)
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        rightView = spacer
        rightViewMode = .always
        
        borderStyle = .none
        
        self.placeholder = placeholder
        layer.cornerRadius = 8
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.black.cgColor
        setHeight(50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
