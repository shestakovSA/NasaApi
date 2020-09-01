//
//  AsteroidsCell.swift
//  NasaApiCS
//
//  Created by Сергей Шестаков on 31.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import UIKit

class AsteroidsCell: UITableViewCell {
    
    // MARK: - Subviews
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var idTitle: UILabel!
    @IBOutlet weak var magnitudeTitle: UILabel!
    @IBOutlet weak var diametrTitle: UILabel!
    @IBOutlet weak var aproachTitle: UILabel!
    @IBOutlet weak var distanceTitle: UILabel!
    @IBOutlet weak var orbitingTitle: UILabel!
    
    // MARK: - Static properties
    static let cellIdentifier = "AsteroidsCell"
    
    // MARK: - Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setup(data: AsteroidCellModel) {
        nameTitle.text = data.name
        idTitle.text = data.id
        magnitudeTitle.text = data.absoluteMagnitude
        diametrTitle.text = data.diametr
        aproachTitle.text = data.aproach
        distanceTitle.text = data.missDistance
        orbitingTitle.text = data.orbiting
    }
}
