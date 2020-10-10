//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by Aaron Lee on 2020-10-10.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Observable.from([1, 2, 3, 4, 5])
    }

}

