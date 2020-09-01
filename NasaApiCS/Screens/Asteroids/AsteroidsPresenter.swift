//
//  AsteroidsPresenter.swift
//  NasaApiCS
//
//  Created by Сергей Шестаков on 31.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import Foundation

protocol AsteroidsPresentationLogic {
    func present(data: [NearEarthObject])
}

class AsteroidsPresenter {

    weak var viewController: AsteroidsViewController?
}

// MARK: - AsteroidsPresentationLogic
extension AsteroidsPresenter: AsteroidsPresentationLogic {
    func present(data: [NearEarthObject]) {
        let viewModelFullInfo = data.map { model -> AsteroidCellModel in
            let cellModelFullInfo = AsteroidCellModel(name: model.name, id: model.id, absoluteMagnitude: String(model.absoluteMagnitudeH), diametr: String(model.estimatedDiameter.meters.estimatedDiameterMax), aproach: model.closeApproachData[0].closeApproachDate, orbiting: model.closeApproachData[0].orbitingBody.rawValue, missDistance: model.closeApproachData[0].missDistance.kilometers)
            return cellModelFullInfo
        }
        viewController?.display(data: viewModelFullInfo)
    }
}
