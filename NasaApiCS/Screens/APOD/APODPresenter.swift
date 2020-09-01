//
//  APODPresenter.swift
//  NasaApiCS
//
//  Created by Сергей Шестаков on 31.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import Foundation

protocol APODPresentationLogic {
    func presenData(data: [Apod])
}

class APODPresenter {
    
    weak var viewController: APODViewController?
}

// MARK: - APODPresentationLogic
extension APODPresenter: APODPresentationLogic {
    func presenData(data: [Apod]) {
        let viewModel = data.map { model -> ApodVCInfoModel in
            let cellModel = ApodVCInfoModel(title: model.title ?? "", dataStr: model.date ?? "", description: model.explanation ?? "", urlPicture: model.hdurl ?? "", urlYoutube: model.url ?? "")
               return cellModel
           }
        print(viewModel)
           viewController?.displayData(data: viewModel)
    }

}
