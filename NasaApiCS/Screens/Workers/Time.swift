//
//  Time.swift
//  NasaApiCS
//
//  Created by Сергей Шестаков on 31.08.2020.
//  Copyright © 2020 Сергей Шестаков. All rights reserved.
//

import Foundation

//MARK: - Global variables
var strData = String()
var actualDate = Date()
var arrayData = [String]()

class Time {
    
    //MARK: - Properties
    let dateFormatter = DateFormatter()
    
    // MARK: - Methods
    func getData() {
        actualDate = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        arrayData.append(dateFormatter.string(from: actualDate))
        strData = (dateFormatter.string(from: actualDate))
    }
    
    func times() {
        var dayComponent = DateComponents()
        let theCalendar = Calendar.current
        dayComponent.day = 1
        for _ in 0..<7 {
            actualDate = theCalendar.date(byAdding: dayComponent, to: actualDate)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            arrayData.append(dateFormatter.string(from: actualDate))
            strData = (dateFormatter.string(from: actualDate))
        }
    }
}
