//
//  AviseViewExtentions.swift
//  AwareCorona
//
//  Created by Meadown on 6/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
extension AdviseViewController: UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //MARK: TAble view Setup
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objAdvices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "advicetablecell", for: indexPath) as! AdviceTableViewCell
        
        cell.lblAdviceLink.text = objAdvices[indexPath.row].adviceTitle
        
        self.activityIndicator.stopAnimating()
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        
        cell.contentView.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = false
        // cell.contentView.layer.shadowColor =  UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
        cell.contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
        cell.contentView.layer.shadowRadius = 2
        cell.contentView.layer.shadowOpacity = 0.5
        
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 25))
      //  headerView.layer.backgroundColor = UIColor.systemBackground.cgColor
           let label = UILabel()
           label.frame = CGRect.init(x: 16, y: 5, width: headerView.frame.width-10, height: headerView.frame.height)
           label.text = "Covid-19 Articles (Advices)"
           label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
           label.textColor = UIColor.label
           headerView.addSubview(label)

           return headerView
       }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          
               return 25
           
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //UIApplication.shared.open(url)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
        let vc = SFSafariViewController(url: URL (string: "\(objAdvices[indexPath.row].adviceLink)")!)
        present(vc, animated: true)
    }
    
    
    
    
    //MARK: Collection view Setup
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView.viewWithTag(1) {
            return protectImages["section1"]!.count
        }
            
        else if collectionView == collectionView.viewWithTag(2) {
            return protectImages["section2"]!.count
        }
            
        else if collectionView == collectionView.viewWithTag(3) {
            return protectImages["section3"]!.count
        }
            
        else if collectionView == collectionView.viewWithTag(4) {
            return protectImages["section4"]!.count
        }
        else
        {
            return 0
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "advisesCollection", for: indexPath) as! adviceCollectionCell
        cell.imgAdvise.layer.cornerRadius = 10
        
        cell.imgAdvise.layer.shadowColor = UIColor.black.cgColor
        cell.imgAdvise.layer.shadowOpacity = 1
        cell.imgAdvise.layer.shadowOffset = .zero
        cell.imgAdvise.layer.shadowRadius = 10
        
        
        
        if collectionView == collectionView.viewWithTag(1) {
            if let arrayImage = protectImages["section1"]{
                cell.imgAdvise.image = arrayImage[indexPath.row]
            }
        }
        else if collectionView == collectionView.viewWithTag(2) {
            if let arrayImage = protectImages["section2"]{
                cell.imgAdvise.image = arrayImage[indexPath.row]
            }
        }
        else if collectionView == collectionView.viewWithTag(3) {
            if let arrayImage = protectImages["section3"]{
                cell.imgAdvise.image = arrayImage[indexPath.row]
            }
        }
        else if collectionView == collectionView.viewWithTag(4) {
            if let arrayImage = protectImages["section4"]{
                cell.imgAdvise.image = arrayImage[indexPath.row]
            }
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 390.0, height: collectionView.frame.height )
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.contentView.layer.cornerRadius = 0
        cell.contentView.layer.masksToBounds = true
        
        cell.contentView.layer.shadowColor = UIColor.black.cgColor
        cell.contentView.layer.shadowOpacity = 0.4
        cell.contentView.layer.shadowOffset = .zero
        cell.contentView.layer.shadowRadius = 3
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -10
        
    }
    
}
