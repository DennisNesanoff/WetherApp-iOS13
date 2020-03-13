//
//  WeatherData.swift
//  WetherApp-iOS13
//
//  Created by Dennis Nesanoff on 13.03.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    let list: [List]
    
}

struct List: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let id: Int
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
}
