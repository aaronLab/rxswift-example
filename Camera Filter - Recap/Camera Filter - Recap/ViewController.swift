//
//  ViewController.swift
//  Camera Filter - Recap
//
//  Created by Aaron Lee on 2020-10-11.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var imgView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
            let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController else {
                fatalError("View Controller Not Found")
        }

        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] img in
            
            DispatchQueue.main.async {
                self?.imgView.image = img
            }
            
        }).disposed(by: self.disposeBag)

    }

}
