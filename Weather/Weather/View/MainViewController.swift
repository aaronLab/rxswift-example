//
//  MainViewController.swift
//  Weather
//
//  Created by Aaron Lee on 2021/03/25.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let textField: UITextField = {
        let tf = CustomTextField(placeholder: "Search here...")
        return tf
    }()
    
    private let labelTemperature: UILabel = {
        let lb = UILabel()
        lb.text = "Temperature"
        lb.font = .systemFont(ofSize: 40, weight: .bold)
        return lb
    }()
    
    private let labelHumidity: UILabel = {
        let lb = UILabel()
        lb.text = "Humidity"
        lb.font = .systemFont(ofSize: 26)
        return lb
    }()
    
    // MARK: - ViewCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    // MARK: - Helpers
    
    private func configureViews() {
        view.backgroundColor = .white
        title = "Good Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // TextField
        view.addSubview(textField)
        textField.anchor(left: view.leftAnchor,
                         top: view.safeAreaLayoutGuide.topAnchor,
                         right: view.rightAnchor,
                         paddingLeft: 16,
                         paddingTop: 16,
                         paddingRight: 16)
        
        // Stack View
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.alignment = .center
        
        view.addSubview(stack)
        stack.center(inView: view)
        stack.anchor(left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingLeft: 16,
                     paddingRight: 16)
        
        stack.addArrangedSubview(labelTemperature)
        stack.addArrangedSubview(labelHumidity)
    }


}

