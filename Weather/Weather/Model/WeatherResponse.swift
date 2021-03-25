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

struct Weather: Decodable {
    let temp: Double?
    let humidity: Double?
}
