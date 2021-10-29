//
//  SymptomsViewExtension.swift
//  AwareCorona
//
//  Created by Meadown on 17/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
extension SymptomsViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 4
        {
            return objSymptomsDis.count
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0
        {
            return 125
        }
        else if indexPath.section == 1
        {
            return 125

        }
        else if indexPath.section == 2 {
            return 125
        }
        else if indexPath.section == 3 {
            return 200
        }
        else if indexPath.section == 4 {
            return 70
        }
            
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "symptoms", for: indexPath) as! symptomsTableViewCell
            cell.lblRowHeader.text = "Common Symptoms"
            return cell
        }
            
        else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "lessSymptoms", for: indexPath) as! lessSymptomsTableViewCell
            cell.lblRowHeader.text = "Less Common Symptoms"
            return cell
        }
            
        else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "criticalSymptoms", for: indexPath) as! criticalSympromsTableViewCell
            cell.lblRowHeader.text = "Critical Symptoms"
            return cell
        }
        else if indexPath.section == 4
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "weblink", for: indexPath) as! symptomsWebLinkTableViewCell
            cell.lblSymptomsTitle.text = objSymptomsDis[indexPath.row].SymptomsDiscussionTitle
             self.activityIndicator.stopAnimating()
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "doctorcell", for: indexPath) as! sickDoctorTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == 4{
            
            
            cell.contentView.layer.cornerRadius = 10
            cell.contentView.layer.masksToBounds = false
            // cell.contentView.layer.shadowColor =  UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
            cell.contentView.layer.shadowOffset = CGSize(width: 1, height: 1)
            cell.contentView.layer.shadowRadius = 2
            cell.contentView.layer.shadowOpacity = 0.5
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 25))
        let label = UILabel()
        label.frame = CGRect.init(x: 16, y: 5, width: headerView.frame.width-10, height: headerView.frame.height)
        label.text = "Covid-19 Articles (Symptoms)"
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 16)
        label.textColor = UIColor.label
        headerView.addSubview(label)

        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 4{return 25}
        else
        {
            return 0
        }
    }
    
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //UIApplication.shared.open(url)
        
        if indexPath.section == 4{
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            let vc = SFSafariViewController(url: URL (string: "\(objSymptomsDis[indexPath.row].SymptomsDiscussionLink)")!)
            present(vc, animated: true)
        }
    }
    
    
}
