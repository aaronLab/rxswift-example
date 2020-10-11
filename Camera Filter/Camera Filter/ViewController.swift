//
//  ViewController.swift
//  Camera Filter
//
//  Created by Aaron Lee on 2020-10-11.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @IBAction func applyFilterPressed(_ sender: UIButton) {
    }
    
}

