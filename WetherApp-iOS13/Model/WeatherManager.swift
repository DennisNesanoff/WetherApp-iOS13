//
//  WeatherManager.swift
//  WetherApp-iOS13
//
//  Created by Dennis Nesanoff on 12.03.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://samples.openweathermap.org/data/2.5/find?"
    
    func fetchWeater(sityName: String) {
        let urlString = "\(weatherURL)&q=\(sityName)$units=metric&appid=e6a1c5270312f2cc57f976cf3fe77dc6"
        print(urlString)
        
        performRequest(urlString)
    }
    
    func performRequest(_ urlString: String) {
        // Create URL
        guard let url = URL(string: urlString) else { return }
        
        // Create a URLSession
        let session = URLSession(configuration: .default)
        
        // Give the session a task
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil {
                print(error)
                return
            }
            
            guard let data = data else { return }
            print(String(data: data, encoding: .utf8))
        }
        
        // Start the task
        task.resume()
    }
}
