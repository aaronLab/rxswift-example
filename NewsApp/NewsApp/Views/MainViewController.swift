//
//  MainViewController.swift
//  NewsApp
//
//  Created by Aaron Lee on 2021/03/24.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate let cellIdentifier = "NewsCell"

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
        
        tableView.register(NewsCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func populateNews() {
        
        URLRequest.load(resource: ArticleList.all)
            .subscribe(onNext: { [weak self] result in
                
                guard let `self` = self else { return }
                
                if let articles = result?.articles {
                    self.articles = articles
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            }).disposed(by: disposeBag)
        
    }
    
}

// MARK: - DataSource

extension MainViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsCell else {
            fatalError("NewsCell not found.")
        }
        
        cell.labelTitle.text = articles[indexPath.row].title ?? ""
        cell.labelDescription.text = articles[indexPath.row].description ?? ""
        
        return cell
    }
    
}
