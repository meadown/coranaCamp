//
//  lessSymptomsTableViewCell.swift
//  AwareCorona
//
//  Created by Meadown on 19/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import UIKit

class lessSymptomsTableViewCell: UITableViewCell,UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var cellno: Int = 0
    var symptoms = SymptomsViewController.SymptomstImage["section1"]
    @IBOutlet weak var lblRowHeader: UILabel!
    @IBOutlet weak var symptomscollection: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        symptomscollection.delegate  = self
        symptomscollection.dataSource = self
        // Initialization code
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
        //cell.imageholderview.layer.shadowOpacity = 0.4
        
      //  cell.imgsymptoms.image = symptoms![indexPath.row]
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
