//
//  HelpLineVIewExtension.swift
//  AwareCorona
//
//  Created by Meadown on 7/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

extension HelpLineViewController :UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return HelplineTitleCount
        if numberState == "help"{
        return objHelpLine.count
        }
        else{
            return objTestLAb.count
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("the section is \(section)")
       if numberState == "help"{
        return objHelpLine[section].numbers.count
        }
        else{
        return objTestLAb[section].numbers.count
        }
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if numberState == "help"{
        return objHelpLine[section].title
        }
        else{
                 return objTestLAb[section].title
            }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "helpLines", for: indexPath) as! HelplineTableViewCell
        
        
        if numberState == "help"{
        cell.lblnumber.text = objHelpLine[indexPath.section].numbers[indexPath.row]
        }
        else{
            cell.lblnumber.text = objTestLAb[indexPath.section].numbers[indexPath.row]
        }
        
        self.activityIndicator.stopAnimating()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //UIApplication.shared.open(url)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
        
       // print(objHelpLine[indexPath.section].numbers[indexPath.row])
        //let url
        if numberState == "help"{
            guard let url = URL(string: "telprompt://\(objHelpLine[indexPath.section].numbers[indexPath.row])") else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        else{
            guard let url = URL(string: "telprompt://\(objTestLAb[indexPath.section].numbers[indexPath.row])") else {return}
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            print(url)
        }
        
       
        
       
    }

    
    
    //MARK: Collection view setup
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        return WebsiteCount
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WebsitesCollection", for: indexPath) as! WebsitesCollectionsCell
        
        
        
        let orgName = website["orgName"]
        let orgLink = website["orgLink"]
        let orgType = website["orgType"]
        
        
        cell.lblOrganizationName.text = orgName?[indexPath.row]
        cell.lblOrgLink.text = orgLink?[indexPath.row]
        
        
        cell.lblOrganizationType.text = orgType?[indexPath.row]
        
        
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var orgLink : [String] = []
        orgLink.append(contentsOf:website["orgLink"]!)

        //MARK: Haptic Feedback(Taptic Engine)
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
       
        //MARk: OPen Website
        let vc = SFSafariViewController(url: URL (string: "\(orgLink[indexPath.row])")!)
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 380.0, height: collectionView.frame.height )
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell .contentView.layer.cornerRadius = 0
        cell.viewWithTag(101)?.layer.cornerRadius = 10
        cell.contentView.layer.masksToBounds = true
        //cell.contentView.layer.shadowColor =  UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
        cell.contentView.layer.shadowOpacity = 0.5
        cell.contentView.layer.shadowOffset = .zero
        cell.contentView.layer.shadowRadius = 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -5
    }
    
}
