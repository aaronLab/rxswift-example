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
    @IBOutlet weak var applyFilterBtn: UIButton!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
            let photosCVC = navC.viewControllers.first as? PhotosCollectionViewController
            else {
                fatalError("Segue Destination is not found")
        }

        photosCVC.selectedPhoto.subscribe(onNext: { [ weak self] photo in
            
            DispatchQueue.main.async {
                self?.updateUI(with: photo)
            }

        }).disposed(by: disposeBag)

    }
    
    private func updateUI(with image: UIImage) {
        self.imgView.image = image
        self.applyFilterBtn.isHidden = false
    }


    @IBAction func applyFilterPressed(_ sender: UIButton) {
        
        guard let sourceImage = self.imgView.image else { return }
        
        FiltersService().applyFilter(to: sourceImage)
            .subscribe(onNext: { filteredImage in
                
                DispatchQueue.main.async {
                    self.imgView.image = filteredImage
                }
                
            }).disposed(by: disposeBag)
        
    }

}

