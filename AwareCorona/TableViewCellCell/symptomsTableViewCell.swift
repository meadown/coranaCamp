    //
    //  symptomsTableViewCell.swift
    //  AwareCorona
    //
    //  Created by Meadown on 17/5/20.
    //  Copyright © 2020 Meadown. All rights reserved.
    //

    import UIKit

    class symptomsTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
        
        var cellno: Int = 0
        var symptoms = SymptomsViewController.SymptomstImage["section0"]
        @IBOutlet weak var lblRowHeader: UILabel!
        @IBOutlet weak var symptomscollection: UICollectionView!
        
        
        override func awakeFromNib() {
            super.awakeFromNib()
            // Initialization code
            symptomscollection.delegate  = self
            symptomscollection.dataSource = self
        }
        
        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
        }
        
        
        func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
        }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            
            return symptoms!.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "symptomscollection", for: indexPath) as! symptomsCollectionViewCell
            
            cell.imageholderview.layer.cornerRadius = 10
            // cell.imageholderview.layer.shadowColor =  UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
           // cell.imageholderview.layer.shadowOffset = CGSize(width: 1, height: 1)
           // cell.imageholderview.layer.shadowRadius = 2
            //cell.imageholderview.layer.shadowOpacity = 0.5
            
           // cell.imgsymptoms.image = symptoms![indexPath.row]
            cell.lblSYmtomsName.text = symptoms![indexPath.row]
            return cell
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 200, height: collectionView.frame.height )
        }
        
        
        
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return -10
            
        }
        
        
    }



    /*
     //Mark: - dark mode check
     //dark mode check start
     func DarkModaeCheck()
     {
     if #available(iOS 12.0, *) {
     switch traitCollection.userInterfaceStyle {
     case .light, .unspecified:
     // light mode detected
     break
     case .dark:
     self.showDialog(title: "Dark Mode", message: "App Not Available in Dark Mode please turn off Dark mode to use the application smoothly.")
     // Mark :- force to light mode
     if #available(iOS 13.0, *) {
     overrideUserInterfaceStyle = .light
     } else {
     // Fallback on earlier versions
     }
     break
     
     }
     } else {
     // Fallback on earlier versions
     }
     }
     //dark mode check end*/

