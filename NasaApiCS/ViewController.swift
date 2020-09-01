//
//  ViewController.swift
//  NasaApiCS
//
//  Created by Сергей Шестаков on 31.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Launch UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        let storyboard = UIStoryboard.init(name: "APODViewController", bundle: nil)
           let asteroidVC = storyboard.instantiateViewController(identifier: "APODViewController") as! APODViewController
        self.navigationController?.pushViewController(asteroidVC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
          navigationController?.setNavigationBarHidden(true, animated: true)
      }
}

