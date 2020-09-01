//
//  AsteroidsInteractor.swift
//  NasaApiCS
//
//  Created by Сергей Шестаков on 31.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import Foundation

protocol AsteroidsBuisnessLogic {
    func fetchAsteroids()
}

class AsteroidsInteractor {
    var presenter: AsteroidsPresentationLogic?
}

// MARK: - AsteroidsBuisnessLogic
extension AsteroidsInteractor: AsteroidsBuisnessLogic {
    func fetchAsteroids() {
        let net = Network()
        var response = [NearEarthObject]()
        net.getResults(from: net.getAsteroidUrl()!) {
            DispatchQueue.main.async {
                response = net.asteroids
                self.presenter?.present(data: response)
            }
        }
    }
}

