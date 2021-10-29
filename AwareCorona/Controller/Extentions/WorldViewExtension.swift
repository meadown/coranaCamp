//
//  WorldViewExtension.swift
//  AwareCorona
//
//  Created by Meadown on 15/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import Foundation
import UIKit

extension WorldViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerData[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       
        if  pickerData[row] == "Select Country"
        {
            print("Select Country")
        }
        else{
        golobalData.country = pickerData[row]
        if golobalData.country != "Bangladesh"
        {
            loadData()
            lblSelwctedCountrydValueChanged()
            chartView.clear()
            
            perform(#selector(imageTappedCountrySelect), with: nil, afterDelay: 1.3)
            
        }
        else
        {
            performSegue(withIdentifier: "BangladeshData", sender: self)
        }
        print(golobalData.country)
        
        }
    }
    
    
    
}
