//
//  UIViewController+Ext.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import UIKit

extension UIViewController {
    
    func showToastAlert(title: String) {
        
        let toast = UIView()
        toast.alpha = 0.0
        
        self.view.addSubview(toast)
        toast.anchor(left: self.view.leftAnchor,
                     right: self.view.rightAnchor,
                     bottom: self.view.safeAreaLayoutGuide.bottomAnchor,
                     width: self.view.frame.width,
                     height: 50.0)
        
        toast.backgroundColor = .red
        
        let lb = UILabel()
        lb.text = title
        lb.textColor = .white
        
        toast.addSubview(lb)
        lb.centerY(inView: toast)
        lb.anchor(left: toast.leftAnchor,
                  right: toast.rightAnchor,
                  paddingLeft: 16,
                  paddingRight: 16)
        
        UIView.animate(withDuration: 0.3) {
            toast.alpha = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.3) {
            UIView.animate(withDuration: 0.3) {
                toast.alpha = 0.0
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.6) {
            toast.removeFromSuperview()
        }
        
    }
    
}
