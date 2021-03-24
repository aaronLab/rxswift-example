//
//  MainViewController.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/03/24.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    private var articles = [Article]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        populateNews()
    }
    
    // MARK: - Helpers
    
    private func configureViews() {
        title = "Good News"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func populateNews() {
        
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(APIKey)") else { return }
        
        Observable.just(url)
            .flatMap { url -> Observable<Data> in
                
                let request = URLRequest(url: url)
                
                return URLSession.shared.rx.data(request: request)
                
            }.map { data -> [Article]? in
                
                return try? JSONDecoder().decode(ArticleList.self, from: data).articles
                
            }.subscribe(onNext: { [weak self] articles in
                
                guard let `self` = self else { return }
                
                if let articles = articles {
                    
                    self.articles = articles
                    
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                        
                    }
                    
                }
                
            }).disposed(by: disposeBag)
        
    }
    
}
