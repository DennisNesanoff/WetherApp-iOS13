//
//  WeatherManager.swift
//  WetherApp-iOS13
//
//  Created by Dennis Nesanoff on 12.03.2020.
//  Copyright © 2020 Dennis Nesanoff. All rights reserved.
//

import Foundation

protocol WeatherDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://samples.openweathermap.org/data/2.5/find?"
    var delegate: WeatherDelegate?
    
    func fetchWeater(sityName: String) {
        let urlString = "\(weatherURL)q=\(sityName)&units=metric&appid=e6a1c5270312f2cc57f976cf3fe77dc6"
//        print(urlString)
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // Create URL
        guard let url = URL(string: urlString) else { return }
        
        // Create a URLSession
        let session = URLSession(configuration: .default)
        
        // Give the session a task
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                self.delegate?.didFailWithError(error: error)
                return
            }
            
            guard let data = data else { return }
            
            if let weather = self.parseJSON(data) {
                self.delegate?.didUpdateWeather(self, weather: weather)
            }
        }
        
        // Start the task
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.list[0].id
            let cityName = decodedData.list[0].name
            let temp = decodedData.list[0].main.temp
            
            return WeatherModel(conditionID: id, cityName: cityName, temperature: temp)
        } catch let error {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

    
}
