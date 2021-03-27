//
//  MainViewController.swift
//  News
//
//  Created by Aaron Lee on 2021/03/27.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
    
    private let cellIdentifier = "NewsCell"
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    
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
        
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func populateNews() {
        
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(APIKey)")!)
        
        URLRequest.load(resource: resource)
            .subscribe(onNext: { [weak self] articleResponse in
                
                guard let `self` = self else { return }
                
                let articles = articleResponse.articles
                self.articleListVM = ArticleListViewModel(articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposeBag)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleListVM == nil ? 0 : articleListVM.articlesVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("NewsTableViewCell is not found.")
        }
        
        let articleVM = articleListVM.articleAt(indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.labelTitle.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.labelDescription.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
    
}
