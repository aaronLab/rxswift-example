//
//  ViewController.swift
//  NewsExample
//
//  Created by Aaron Lee on 2021-04-05.
//

import UIKit
import RxSwift

class NewsTableViewController: UITableViewController {
    
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        populateNews()
    }
    
    private func configureViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News App"
    }
    
    private func populateNews() {
        
        let resource = Resource<ArticleResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=\(APIKEY)")!)
        
//        URLRequest.load(resource: resource)
//            .subscribe(onNext: {
//                print($0)
//            })
//            .disposed(by: bag)
        
    }


}

