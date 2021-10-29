//
//  iOSDeviceCheck.swift
//  AwareCorona
//
//  Created by Meadown on 2/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import Foundation
import UIKit
class iOSDeviceCheck {
    
    
    
    static func device() -> String{
        var result : String = " "
        
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                print("iPhone 5 or 5S or 5C")
                result = "noNotch"
            case 1334:
                print("iPhone 6/6S/7/8")
                 result = "noNotch"
            case 1920, 2208:
                print("iPhone 6+/6S+/7+/8+")
                 result = "noNotch"
            case 2436:
                print("iPhone X/XS/11 Pro")
                 result = "Notch"
            case 2688:
                print("iPhone XS Max/11 Pro Max")
                result = "Notch"
            case 1792:
                print("iPhone XR/ 11 ")
                result = "Notch"
            default:
                print("Unknown")
                result = "Notch"
            }
        }
        return result
    }
    
    
    
    
}
