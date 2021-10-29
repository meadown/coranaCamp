//
//  SymptomsViewController.swift
//  AwareCorona
//
//  Created by Meadown on 15/5/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import UIKit
 import Firebase
class SymptomsDiscussion {
    
    var SymptomsDiscussionTitle : String
    var SymptomsDiscussionLink : String
    
    
    init(title: String,link: String) {
        SymptomsDiscussionTitle = title
        SymptomsDiscussionLink = link
        
    }
    
}
class SymptomsViewController: UIViewController {
    //MARK: VAriables
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var advicesCollectionRef = Firestore.firestore().collection("symptompsdis")
    var objSymptomsDis = [SymptomsDiscussion]()
    static var  SymptomstImage = [
               "section0":["Fever","Dry Cough","Tiredness"],
               "section1":["Aches and Pains","Sore Throat","Diarrhoea","Conjunctivitis","Headache","A rash on skin","Loss of Taste or Smell"
               ,"Discolouration of fingers or toes"],
               "section2":["Difficulty of breathing","Shortness of breath","Chest pain or pressure","Loss of speech or movement"]
           ]
    
    /*
     "section0":[#imageLiteral(resourceName: "Asset 23"),#imageLiteral(resourceName: "dry"),#imageLiteral(resourceName: "tired")],
     "section1":[#imageLiteral(resourceName: "sore"),#imageLiteral(resourceName: "dairia"),#imageLiteral(resourceName: "head_1"),#imageLiteral(resourceName: "conjunc"),#imageLiteral(resourceName: "rash2"),#imageLiteral(resourceName: "pain"),#imageLiteral(resourceName: "taste"),#imageLiteral(resourceName: "discolour")],
     "section2":[#imageLiteral(resourceName: "diff"),#imageLiteral(resourceName: "short"),#imageLiteral(resourceName: "chest_pain"),#imageLiteral(resourceName: "speech_movement")]
    */
    
    
    //MARK: All View Outlates
    @IBOutlet weak var TabBarView: UIView!
    @IBOutlet weak var SymptomsTable: UITableView!
    
    //MARK: All TAbBar Item Oulet ANd Actions
    @IBOutlet weak var imgStatistics: UIImageView!{
        didSet{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(StatisticsTaped))
            imgStatistics.addGestureRecognizer(tapGesture)
            imgStatistics.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var imgAdvices: UIImageView!{
        didSet{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AdvicesTaped))
            imgAdvices.addGestureRecognizer(tapGesture)
            imgAdvices.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var imgInfo: UIImageView!{
        didSet{
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(InfoTaped))
        imgInfo.addGestureRecognizer(tapGesture)
        imgInfo.isUserInteractionEnabled = true
        }
    }
    
    @objc func StatisticsTaped()
    {
        if golobalData.country == "Bangladesh"{
        performSegue(withIdentifier: "statisticsBD", sender: self)
        }
        else{
             performSegue(withIdentifier: "statisticsWD", sender: self)
        }
    }
    
    @objc func AdvicesTaped()
        {
        performSegue(withIdentifier: "advices", sender: self)
    }
    
    @objc func InfoTaped(){
         performSegue(withIdentifier: "info", sender: self)
    }
    
    
    
    func activityLoader()
    {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.color = UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0)
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupview()

        SymptomsDiscutionReaddatafromFirebase()
        SymptomsTable.delegate = self
        SymptomsTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    

    func setupview(){
        
        //MARK: Tababr Setup
        TabBarView.layer.masksToBounds = false
        //TabBarView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
        TabBarView.layer.shadowColor =  UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
        TabBarView.layer.shadowOffset = CGSize(width: 1, height: 1)
        TabBarView.layer.shadowRadius = 2
        TabBarView.layer.shadowOpacity = 1
        
    }
    
    
    func SymptomsDiscutionReaddatafromFirebase()
    {
        self.activityLoader()
        
        advicesCollectionRef.getDocuments { (advice, error) in
            if let err = error {
                print(err)
            }
            else{
                guard let advices = advice else{ return }
                for elemnents in advices.documents{
                    let data = elemnents.data()
                    let title = data["title"] as! String
                    let link = data["link"] as! String
                    let newobjAdvices = SymptomsDiscussion(title: title, link: link)
                    self.objSymptomsDis.append(newobjAdvices)
                    self.SymptomsTable.reloadData()
                }
                
            }
            
        }
        
    }
    
    
    

}
