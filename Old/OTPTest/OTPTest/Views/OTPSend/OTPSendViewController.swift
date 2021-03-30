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
    private let loader = UIView()
    
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
        
        // Stack
        stack.addArrangedSubview(textField)
        stack.addArrangedSubview(button)
        view.addSubview(stack)
        
        // Loader
        UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.addSubview(loader)
        
    }
    
    func configureAttributes() {
        // View
        title = "Send"
        view.backgroundColor = .white
        
        // Stack
        stack.axis = .vertical
        stack.spacing = 16
        stack.center(inView: view)
        stack.anchor(left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingLeft: 16,
                     paddingRight: 16)
        
        // Textfield
        textField.placeholder = "01012341234"
        textField.borderStyle = .roundedRect
        
        // Button
        button.setTitle("Send", for: .normal)
        
        // Loader
        loader.fillSuperview()
        loader.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        loader.alpha = 0
        
        // Loadeer Indicator
        let loadingIndicator = UIActivityIndicatorView(frame: .zero)
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.medium
        loadingIndicator.startAnimating()
        loader.addSubview(loadingIndicator)
        loadingIndicator.center(inView: loader)
    }
    
    func bindRX() {
        
        textField.rx.text.orEmpty.bind(to: viewModel.mobileNoValueChanged).disposed(by: disposeBag)
        
        button.rx.tap.bind(to: viewModel.sendButtonPressed).disposed(by: disposeBag)
        
        // For Loading View
        viewModel.isLoading
            .subscribe(onNext: { [weak self] isLoading in
                guard let `self` = self else { return }
                
                if isLoading {
                    DispatchQueue.main.async {
                        self.loader.alpha = 1
                    }
                } else {
                    DispatchQueue.main.async {
                        self.loader.alpha = 0
                    }
                }
            })
            .disposed(by: disposeBag)
        
        // Loaded Response
        viewModel.sendOTPResponse
            .subscribe(onNext: { [weak self] response in
                guard let `self` = self else { return }
                guard let response = response else { return }
                
                #if DEBUG
                dump(response)
                #endif
                
                if !response.success {
                    // Response Error
                    self.showAlert(message: response.description)
                } else {
                    // Response Success
                    DispatchQueue.main.async {
                        let vc = OTPConfirmViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
            })
            .disposed(by: disposeBag)
    }
    
}

extension OTPSendViewController {
    
    private func showAlert(title: String = "Error", message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            self.present(alert, animated: true) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
}
