//
//  ViewController.swift
//  PhotoFilter
//
//  Created by Aaron Lee on 9/17/20.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
              let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController
        else { return }
        
        photosCVC.selectedPhoto.subscribe(onNext: { [weak self] photo in
            
            self?.photoImageView.image = photo
            
        }).disposed(by: self.disposeBag)
        
    }

}

