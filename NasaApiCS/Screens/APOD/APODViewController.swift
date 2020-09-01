//
//  APODViewController.swift
//  NasaApiCS
//
//  Created by Сергей Шестаков on 31.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import UIKit
import Foundation
import Kingfisher
import Zoomy
import SafariServices

protocol APODDisplayLogic: class {
    func displayData(data: [ApodVCInfoModel])
}

class APODViewController: UIViewController {
    
    // MARK: - Subviews
    @IBOutlet weak var backTitleView: UIView!
    @IBOutlet weak var backPictureView: UIView!
    @IBOutlet weak var showAsteroidButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backDataView: UIView!
    @IBOutlet weak var discriptionLabel: UILabel!
    @IBOutlet weak var starImagView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var dataLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func tapTitleName(_ sender: Any) {
        if dataToDisplay[0].urlYoutube != "" {
            let svc = SFSafariViewController(url: URL(string: dataToDisplay[0].urlYoutube) ?? URL(string: "https://www.nasa.gov")!)
            present(svc, animated: true, completion: nil)
        }
    }
    
    @IBAction func showAsteroids(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "AsteroidsViewController", bundle: nil)
        let asteroidVC = storyboard.instantiateViewController(identifier: "AsteroidsViewController") as! AsteroidsViewController
        self.navigationController?.pushViewController(asteroidVC, animated: true)
    }
    
    // MARK: - Private object
    private var interactor: APODBuisnessLogic?
    private var dataToDisplay = [ApodVCInfoModel]()
    
    // MARK: - Private method
    private func setup() {
        let viewController = self
        let presenter = APODPresenter()
        let interactor = APODInteractor()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
        
    }
    
    private func configureView() {
        backTitleView.layer.cornerRadius = 20
        backTitleView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        scrollView.layer.cornerRadius = 20
        scrollView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        showAsteroidButton.layer.cornerRadius = 20
        scrollView.contentLayoutGuide.bottomAnchor.constraint(equalTo: discriptionLabel.bottomAnchor).isActive = true
        let settings = Settings.defaultSettings
            .with(actionOnTapOverlay: Action.dismissOverlay)
            .with(actionOnDoubleTapImageView: Action.zoomToFit)
        addZoombehavior(for: starImagView, settings: settings)
    }
    
    // MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        interactor?.fetchAPOD()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        imageZoomControllers.values.forEach{ $0.dismissOverlay() }
    }
    
}

// MARK: - APODDisplayLogic
extension APODViewController: APODDisplayLogic {
    func displayData(data: [ApodVCInfoModel]) {
        dataToDisplay.removeAll()
        dataToDisplay.append(contentsOf: data)
        //Config title
        titleLabel.text = dataToDisplay[0].title
        discriptionLabel.text = dataToDisplay[0].description
        dataLabel.text = dataToDisplay[0].dataStr
        //Config Image
        var urlImage = URL(string: "")
        if dataToDisplay[0].urlPicture == "" {
            urlImage = URL(string: "https://lh3.googleusercontent.com/lMoItBgdPPVDJsNOVtP26EKHePkwBg-PkuY9NOrc-fumRtTFP4XhpUNk_22syN4Datc")
        } else {
            urlImage = URL(string: dataToDisplay[0].urlPicture)
        }
        self.starImagView.kf.indicatorType = .activity
        self.starImagView.kf.setImage(
            with: urlImage,
            placeholder: UIImage(named: "placeholderImage"),
            options: [
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage,
                .memoryCacheExpiration(.days(1))
        ])
    }
}
