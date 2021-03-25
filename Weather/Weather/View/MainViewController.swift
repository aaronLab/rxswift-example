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
        return tf
    }()
    
    private let labelTemperature: UILabel = {
        let lb = UILabel()
        lb.text = "N/A"
        lb.font = .systemFont(ofSize: 40, weight: .bold)
        return lb
    }()
    
    private let labelHumidity: UILabel = {
        let lb = UILabel()
        lb.text = "N/A"
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
        textField.rx.value
            .subscribe(onNext: { city in
                
                guard let city = city else { return }
                
                if city.isEmpty {
                    self.displayWeather(nil)
                } else {
                    self.fetchWeather(by: city)
                }
                
            }).disposed(by: disposeBag)
    }
    
    private func displayWeather(_ weather: Weather?) {
        guard let weather = weather,
              let temp = weather.temp,
              let humidity = weather.humidity else {
            labelTemperature.text = "N/A"
            labelHumidity.text = "N/A"
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
        
        URLRequest.load(resource: resource)
            .catchAndReturn(WeatherResponse.empty)
            .subscribe(onNext: { [weak self] result in
                guard let weather = result.main else { return }
                self?.displayWeather(weather)
            }).disposed(by: disposeBag)
    }

}

