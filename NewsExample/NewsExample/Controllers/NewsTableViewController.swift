//
//  ViewController.swift
//  NewsExample
//
//  Created by Aaron Lee on 2021-04-05.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {

    private let cellIdentifier = "NewsTableViewCell"
    private let bag = DisposeBag()
    private var articleListVM: ArticleListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        configureViews()
        populateNews()
    }

    private func configureViews() {
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News App"
    }

    private func populateNews() {

        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(APIKEY)")!)

        URLRequest.load(resource: resource)
            .subscribe(onNext: { [weak self] articleResponse in
            guard let self = self else { return }

            let articles = articleResponse.articles
            self.articleListVM = ArticleListViewModel(articles)

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }

                self.tableView.reloadData()
            }

        })
            .disposed(by: bag)

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? NewsTableViewCell else {
            fatalError("NewsTableViewCell is not found!")
        }

        let articleVM = articleListVM.articleAt(indexPath.row)

        articleVM.title
            .asDriver(onErrorJustReturn: "")
            .drive(cell.labelTitle.rx.text)
            .disposed(by: bag)

        articleVM.description
            .asDriver(onErrorJustReturn: "")
            .drive(cell.labelDescription.rx.text)
            .disposed(by: bag)

        return cell
    }

}

class NewsTableViewCell: UITableViewCell {

    let labelTitle: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 17)
        return lb
    }()

    let labelDescription: UILabel = {
        let lb = UILabel()
        lb.numberOfLines = 0
        lb.font = .systemFont(ofSize: 14)
        lb.textColor = .systemGray
        lb.setContentHuggingPriority(UILayoutPriority(252), for: .vertical)
        return lb
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8.0

        stack.addArrangedSubview(labelTitle)
        stack.addArrangedSubview(labelDescription)

        contentView.addSubview(stack)
        stack.anchor(left: contentView.leftAnchor,
            top: contentView.topAnchor,
            right: contentView.rightAnchor,
            bottom: contentView.bottomAnchor,
            paddingLeft: 8,
            paddingTop: 8,
            paddingRight: 8,
            paddingBottom: 8)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
