//
//  APODInteractor.swift
//  NasaApiCS
//
//  Created by Сергей Шестаков on 31.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import Foundation

protocol APODBuisnessLogic {
    func fetchAPOD()
}

class APODInteractor {
    var presenter: APODPresentationLogic?
}

// MARK: - APODBuisnessLogic
extension APODInteractor: APODBuisnessLogic {
    func fetchAPOD() {
        let net = Network()
        var response = [Apod]()
        net.getResults(from: net.getApodUrl()!) {
            DispatchQueue.main.async {
                response = net.apod
                self.presenter?.presenData(data: response)
            }
        }
    }
}
