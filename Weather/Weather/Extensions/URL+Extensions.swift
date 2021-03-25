//
//  URL+Extensions.swift
//  Weather
//
//  Created by Aaron Lee on 2021/03/25.
//

import Foundation

extension URL {
    
    static func urlForWeatherAPI(city: String) -> URL? {
        return URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&APPID=\(APIKey)&units=metric")
    }
    
}
