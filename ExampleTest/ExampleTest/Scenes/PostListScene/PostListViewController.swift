//
//  PostListViewController.swift
//  ExampleTest
//
//  Created by Aaron Lee on 2021-04-05.
//

import UIKit
import RxSwift
import RxCocoa

class PostListViewController: UITableViewController {
    
    // MARK: - Private Properties
    
    private let viewModel = PostListViewModel()
    private let bag = DisposeBag()
    private let cellIdentifier = "PostListViewCell"
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        bindViewModel()
    }
    
    // MARK: - Helper

    private func configureView() {

        title = "Post List"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(PostListViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    private func bindViewModel() {
        viewModel.isLoading
            .subscribe(onNext: { isLoading in

                if !isLoading {
                    
                    DispatchQueue.main.async { [weak self] in
                        
                        self?.tableView.reloadData()
                        
                    }
                    
                }
            })
            .disposed(by: bag)
        
        viewModel.error
            .subscribe(onNext: { error in
                print(error)
            })
            .disposed(by: bag)
        
        viewModel.loadPostList()
    }

}

// MARK: - Data Source

extension PostListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.postList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PostListViewCell else {
            fatalError("PostListViewCell is not found")
        }
        
        let post = viewModel.postAt(indexPath.row)
        
        post.title
            .asDriver(onErrorJustReturn: "")
            .drive(cell.labelTitle.rx.text)
            .disposed(by: bag)
        
        post.description
            .asDriver(onErrorJustReturn: "")
            .drive(cell.labelBody.rx.text)
            .disposed(by: bag)
        
        return cell
    }
    
}
