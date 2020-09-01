//
//  AsteroidsViewController.swift
//  NasaApiCS
//
//  Created by Сергей Шестаков on 31.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import UIKit

protocol AsteroidsDisplayLogic: class {
    func display(data: [AsteroidCellModel])
}

class AsteroidsViewController: UIViewController {
    
    // MARK: - Subviews
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Private object
    private var interactor: AsteroidsBuisnessLogic?
    private var dataToDisplay = [AsteroidCellModel]()
    
    // MARK: - Object
    var time = Time()
    
    // MARK: - Properties
    var featchingMore = false
    
    // MARK: Init
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
        configureTableView()
        time.getData()
        interactor?.fetchAsteroids()
    }
    override func viewWillDisappear(_ animated: Bool) {
        arrayData.removeAll()
    }
    
    // MARK: - Private Method
    private func setup() {
        let viewController = self
        let presenter = AsteroidsPresenter()
        let interactor = AsteroidsInteractor()
        interactor.presenter = presenter
        presenter.viewController = viewController
        viewController.interactor = interactor
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "AsteroidsCell", bundle: nil), forCellReuseIdentifier: AsteroidsCell.cellIdentifier)
    }
    private func beginUpdateTableView() {
        featchingMore = true
        interactor?.fetchAsteroids()
    }
}

// MARK: - AsteroidsDisplayLogic
extension AsteroidsViewController: AsteroidsDisplayLogic {
    func display(data: [AsteroidCellModel]) {
        dataToDisplay.append(contentsOf: data)
        featchingMore = false
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension AsteroidsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AsteroidsCell.cellIdentifier, for: indexPath) as? AsteroidsCell
            else {return UITableViewCell()}
        cell.setup(data: dataToDisplay[indexPath.row]) 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentTop = scrollView.contentOffset.y
        let contentHight = scrollView.contentSize.height
        //print("Raznica: \(contentHight - scrollView.frame.height)")
        if contentTop > contentHight - scrollView.frame.height {
            if contentHight - scrollView.frame.height > 0 {
                if !featchingMore {
                    beginUpdateTableView()
                }
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


