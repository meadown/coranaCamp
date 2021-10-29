//
//  BdViewExtentions.swift
//  AwareCorona
//
//  Created by Meadown on 6/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import Foundation
import UIKit

extension BDViewController: UIPickerViewDelegate,UIPickerViewDataSource{
  
    //MARK: Picker view data load
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
              1
          }
          
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
              return pickerData.count
          }
          
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
              return pickerData[row]
          }
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
             
        if  pickerData[row] == "Select Country"
        {
            print("Select Country")
        }
        else{
        golobalData.country = pickerData[row]
              if golobalData.country != "Bangladesh"
              {
                  performSegue(withIdentifier: "WorldData", sender: self)
                  
              }
            }
          }
    
    
}


