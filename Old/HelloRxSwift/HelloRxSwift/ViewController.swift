//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by Aaron Lee on 2021/03/21.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = Observable.from([1, 2, 3, 4, 5])
    }


}

