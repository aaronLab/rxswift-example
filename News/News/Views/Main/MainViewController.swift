//
//  MainViewController.swift
//  News
//
//  Created by Aaron Lee on 2021/03/27.
//

import UIKit
import RxSwift

class MainViewController: UITableViewController {
    
    private let cellIdentifier = "NewsCell"
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        populateNews()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    private func configureView() {
        view.backgroundColor = .white
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func populateNews() {
        
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(APIKey)")!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
        
    }
    
}
