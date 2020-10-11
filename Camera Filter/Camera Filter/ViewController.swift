//
//  ViewController.swift
//  Camera Filter
//
//  Created by Aaron Lee on 2020-10-11.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    @IBAction func applyFilterPressed(_ sender: UIButton) {
    }
    
}

