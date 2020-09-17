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
    @IBOutlet weak var filterButton: UIButton!
    
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
            
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }
            
        }).disposed(by: self.disposeBag)
        
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        
        guard let sourceImage = self.photoImageView.image else { return }
        
        FilterService().applyFilter(to: sourceImage)
            .subscribe(onNext: { filteredImage in
                
                DispatchQueue.main.async {
                    self.photoImageView.image = filteredImage
                }
                
            }).disposed(by: disposeBag)
        
    }
    
    private func updateUI(with image: UIImage) {
        self.photoImageView.image = image
        self.filterButton.isHidden = false
    }
    
}

