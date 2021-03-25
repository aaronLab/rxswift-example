//
//  WeatherResponse.swift
//  Weather
//
//  Created by Aaron Lee on 2021/03/25.
//

import Foundation

struct WeatherResponse: Decodable {
    let main: Weather?
}

extension WeatherResponse {
    
    static var empty: WeatherResponse {
        return WeatherResponse(main: Weather(temp: 0, humidity: 0))
    }
    
}

struct Weather: Decodable {
    let temp: Double?
    let humidity: Double?
}
