//
//  golobalData.swift
//  AwareCorona
//
//  Created by Meadown on 1/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import Foundation
import UIKit
class golobalData {
    static var yesterday : String = " "
    static var Today : String = " "
    static var  country : String = ""
    static var result : Int = 0
    
    static var symptoms : [UIImage] = []
    static var symptomscount : Int = 0
    
    static var symptomsCount : Int = 0
    
    
    private static let defaults = UserDefaults.standard
    
    init() {
        
        
    }
    
    static func getToday() -> String
    {
        let now = Date()// Current date
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "Y-MM-dd"
        golobalData.Today = dateFormatterPrint.string(from: now)
        
        return dateFormatterPrint.string(from: now)
    }
    
    static func getYesterday() -> String
    {
        var dateComponents = DateComponents()
        dateComponents.setValue(-1, for: .day) // -1 day
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "Y-MM-dd"
        
        let now = Date()// Current date
        let yesterday = Calendar.current.date(byAdding: dateComponents, to: now) // Add the DateComponents
        
        print(now)
        golobalData.yesterday = dateFormatterPrint.string(from: yesterday!)
        return dateFormatterPrint.string(from: yesterday!)
    }
    
    
    static func FormatedCurrentTime() -> String
    {
        var dateComponents = DateComponents()
        dateComponents.setValue(-1, for: .day) // -1 day
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "h:mm a"
        
        let now = Date()// Current date
        let yesterday = Calendar.current.date(byAdding: dateComponents, to: now) // Add the DateComponents
        
        print(now)
        golobalData.yesterday = dateFormatterPrint.string(from: yesterday!)
        return dateFormatterPrint.string(from: yesterday!)
    }
    
    
    static func setCountryName(country: String)
    {
        golobalData.country = country
    }
    
    
}
