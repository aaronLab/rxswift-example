//
//  MainViewController.swift
//  NewsApi
//
//  Created by Aaron Lee on 2021/03/21.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        populateNews()
    }
    
    // MARK: - Actions
    
    // MARK: - Helpers
    
    private func setupViews() {
        view.backgroundColor = .white
        title = "News App"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func populateNews() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(APIKey)") else { return }
        let resource = Resource<ArticleResponse>(url: url)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: {
                print($0)
            })
            .disposed(by: disposeBag)
    }

}

