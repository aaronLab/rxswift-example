//
//  OTPSendViewController.swift
//  OTPTest
//
//  Created by Aaron Lee on 2021/03/28.
//

import UIKit
import RxSwift
import RxCocoa

class OTPSendViewController: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private let viewModel = OTPSendViewModel()
    
    private let stack = UIStackView()
    private let textField = UITextField()
    private let button = UIButton(type: .system)
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAttributes()
        bindRX()
    }
    
}

// MARK: - BaseViewController

extension OTPSendViewController: BaseViewController {
    
    func configureUI() {
        
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(button)
        view.addSubview(stack)
        
    }
    
    func configureAttributes() {
        view.backgroundColor = .white
        
        stack.axis = .vertical
        stack.center(inView: view)
        
        textField.placeholder = "01012341234"
        textField.borderStyle = .roundedRect
        
        button.setTitle("Send", for: .normal)
    }
    
    func bindRX() {
        textField.rx.text.orEmpty.bind(to: viewModel.mobileNoValueChanged).disposed(by: disposeBag)
        button.rx.tap.bind(to: viewModel.sendButtonPressed).disposed(by: disposeBag)
        
        viewModel.sendOTPResponse
            .subscribe(onNext: { [weak self] response in
                
                guard let `self` = self else { return }
                guard let response = response else { return }
                
                if !response.success {
                    self.showAlert(message: response.description)
                } else {
                    
                }
                
            }).disposed(by: disposeBag)
    }
    
}

extension OTPSendViewController {
    
    private func showAlert(title: String = "Error", message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
            self.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}
