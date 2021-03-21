//
//  MainViewController.swift
//  NewsApi
//
//  Created by Aaron Lee on 2021/03/21.
//

import UIKit
import RxSwift

private let cellIdentifier = "ReusableNewsCell"

class NewsTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    
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
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func populateNews() {
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(APIKey)") else { return }
        let resource = Resource<ArticleResponse>(url: url)

        URLRequest.load(resource: resource)
            .subscribe(onNext: { articleResponse in
                
                guard let articles = articleResponse.articles else { return }
                
                self.articleListVM = ArticleListViewModel(articles)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            })
            .disposed(by: disposeBag)
    }

}

// MARK: - DataSource

extension NewsTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.articlesVM.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("NewsTableViewCell is not found")
        }
        
        let articleVM = self.articleListVM.articleAt(indexPath.row)
        
        articleVM.title.asDriver(onErrorJustReturn: "")
            .drive(cell.labelTitle.rx.text)
            .disposed(by: disposeBag)
        
        articleVM.description.asDriver(onErrorJustReturn: "")
            .drive(cell.labelDescription.rx.text)
            .disposed(by: disposeBag)
        
        return cell
    }
    
}
