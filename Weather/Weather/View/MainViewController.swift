//
//  MainViewController.swift
//  Weather
//
//  Created by Aaron Lee on 2021/03/25.
//

import UIKit
import RxSwift
//import RxCocoa

class MainViewController: UIViewController {
    
    // MARK: - Properties
    
    private let disposeBag = DisposeBag()
    
    private let textField: UITextField = {
        let tf = CustomTextField(placeholder: "Search here...")
        tf.returnKeyType = .search
        return tf
    }()
    
    private let labelTemperature: UILabel = {
        let lb = UILabel()
        lb.text = "Temperature"
        lb.font = .systemFont(ofSize: 40, weight: .bold)
        return lb
    }()
    
    private let labelHumidity: UILabel = {
        let lb = UILabel()
        lb.text = "Humidity"
        lb.font = .systemFont(ofSize: 26)
        return lb
    }()
    
    // MARK: - ViewCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        setupTextField()
    }
    
    // MARK: - Helpers
    
    private func configureViews() {
        view.backgroundColor = .white
        title = "Good Weather"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // TextField
        view.addSubview(textField)
        textField.anchor(left: view.leftAnchor,
                         top: view.safeAreaLayoutGuide.topAnchor,
                         right: view.rightAnchor,
                         paddingLeft: 16,
                         paddingTop: 16,
                         paddingRight: 16)
        
        // Stack View
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 32
        stack.alignment = .center
        
        view.addSubview(stack)
        stack.center(inView: view)
        stack.anchor(left: view.leftAnchor,
                     right: view.rightAnchor,
                     paddingLeft: 16,
                     paddingRight: 16)
        
        stack.addArrangedSubview(labelTemperature)
        stack.addArrangedSubview(labelHumidity)
    }
    
    private func setupTextField() {
        
        textField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.textField.text }
            .subscribe(onNext: { [weak self] city in
                
                if let city = city {
                    if !city.isEmpty {
                        self?.fetchWeather(by: city)
                    }
                }
                
            }).disposed(by: disposeBag)
        
    }
    
    private func displayWeather(_ weather: Weather?) {
        guard let weather = weather,
              let temp = weather.temp,
              let humidity = weather.humidity else {
            labelTemperature.text = "Temperature"
            labelHumidity.text = "Humidity"
            return
        }
        
        DispatchQueue.main.async {
            self.labelTemperature.text = "\(temp) C"
            self.labelHumidity.text = "\(humidity) %"
        }
        
    }
    
    private func fetchWeather(by city: String) {
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed),
              let url = URL.urlForWeatherAPI(city: cityEncoded) else { return }
        
        let resource = Resource<WeatherResponse>(url: url)
        
        let search = URLRequest.load(resource: resource)
            .observe(on: MainScheduler.instance)
            .asDriver(onErrorJustReturn: WeatherResponse.empty)
        
        search.map { "\($0.main?.temp ?? 0) C" }
            .drive(labelTemperature.rx.text)
            .disposed(by: disposeBag)
        
        search.map { "\($0.main?.humidity ?? 0) %" }
            .drive(labelHumidity.rx.text)
            .disposed(by: disposeBag)
    }

}

