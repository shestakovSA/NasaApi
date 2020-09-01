//
//  Network.swift
//  NasaApiCS
//
//  Created by Сергей Шестаков on 31.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import Foundation

class Network {
    //MARK: - Properties
    var errorMessage = String()
    let decoder = JSONDecoder()
    //check URL
    var switchId: Int = 0
    
    //MARK: - URL
    var apodUrl = URLComponents(string: "https://api.nasa.gov/planetary/apod?")
    var asteroidUrl = URLComponents(string: "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(strData)")
    
    //MARK: - Api Parametrs
    let secretAPIKey = URLQueryItem(name: "api_key", value: "rjIJugP60DSP3p1iQFgHFTdaxL7DKScxcBcAzH3a")
    
    //MARK: - Funcion of get URL
    func getApodUrl() -> URL? {
        switchId = 1
        apodUrl?.queryItems?.append(secretAPIKey)
        return apodUrl?.url
    }
    
    func getAsteroidUrl() -> URL? {
        switchId = 2
        asteroidUrl?.queryItems?.append(secretAPIKey)
        return asteroidUrl?.url
    }
    
    //MARK: - Object
    var asteroids = [NearEarthObject]()
    var apod = [Apod]()
    let time = Time()
    
    //MARK: - Network
    func getResults(from url: URL, completion: @escaping () -> ()) {
        URLSession.shared.dataTask(with: url) { (data, response, error ) in
            guard let data = data else { return }
            switch self.switchId {
            case 1: self.updateResultsApod(data)
            case 2: self.updateResultsAsteoid(data)
            default: break
            }
            completion()
        }.resume()
    }
    
    fileprivate func updateResultsApod(_ data: Data) {
        decoder.dateDecodingStrategy = .iso8601
        do {
            let rawFeed = try decoder.decode(Apod.self, from: data)
            apod.append(rawFeed)
        } catch let decodeError as NSError {
            errorMessage += "Decoder error: \(decodeError.localizedDescription)"
            return
        }
    }
    
    fileprivate func updateResultsAsteoid(_ data: Data) {
        decoder.dateDecodingStrategy = .iso8601
        do {
            let rawFeed = try decoder.decode(Asteroids.self, from: data)
            time.times()
            for dataAproach in arrayData {
                asteroids.append(contentsOf: rawFeed.nearEarthObjects[dataAproach] ?? [])
            }
        } catch let decodeError as NSError {
            errorMessage += "Decoder error: \(decodeError.localizedDescription)"
            return
        }
    }
}
