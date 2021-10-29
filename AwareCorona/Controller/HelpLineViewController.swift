//
//  HelpLineViewController.swift
//  AwareCorona
//
//  Created by Meadown on 23/4/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import UIKit
import Firebase

class helplines {
    
    var title : String
    var numbers : [String]
    
    init(settitle : String, setnumber : [String]) {
        title = settitle
        numbers = setnumber
    }
    
}


class HelpLineViewController: UIViewController{
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    
    var db = Firestore.firestore()
    var helplinecollectionRef = Firestore.firestore().collection("helpline")
    var testlabCollectionRef = Firestore.firestore().collection("coronatestcenter")
    var objHelpLine = [helplines]()
    var objTestLAb = [helplines]()
    var numberState : String = "help"

    var website = [String: Array<String>]()
    var helpline = [String: Array<String>]()
  
    var WebsiteCount : Int = 0
    var HelplineTitleCount : Int = 0
   // var HelplineState : String = "Calcenter"
    static var WhichView :  String = "Bd"
    //MARK: CollectionView
    @IBOutlet weak var WebSitesCollections: UICollectionView!
    @IBOutlet weak var HelplinesTable: UITableView!
    {
        didSet{
            let tapestureleft = UISwipeGestureRecognizer(target: self, action: #selector(AllCallCenterTaped))
            let tapestureRight = UISwipeGestureRecognizer(target: self, action: #selector(AllTestLabTaped))
             let tapestureDown = UISwipeGestureRecognizer(target: self, action: #selector(AllTestLabTaped))
            tapestureRight.direction = UISwipeGestureRecognizer.Direction.right
            tapestureleft.direction = UISwipeGestureRecognizer.Direction.left
            tapestureDown.direction = UISwipeGestureRecognizer.Direction.down
            
            self.HelplinesTable.addGestureRecognizer(tapestureleft)
            self.HelplinesTable.addGestureRecognizer(tapestureRight)
            self.HelplinesTable.addGestureRecognizer(tapestureDown)
        }
    }
    
    
    @IBOutlet weak var HelplineTableHolder: UIView!
    @IBOutlet weak var TabbarView: UIView!
    @IBOutlet weak var CallCenterIndicator: UIView!
    @IBOutlet weak var TestLabIndicator: UIView!
    
    //MARK: Toggle Item Header
    @IBOutlet weak var AllCallCenter: UILabel!
    {
        didSet
        {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AllCallCenterTaped))
            AllCallCenter.addGestureRecognizer(tapGesture)
            AllCallCenter.isUserInteractionEnabled = true
        }
    }
    
    @objc func AllCallCenterTaped()
    {
        self.numberState = "help"
        
        //MARK: GEnerate taptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        
        self.TestLabIndicator.layer.backgroundColor = UIColor.systemGray3.cgColor
        self.AllTestLab.textColor = UIColor.systemGray
        self.CallCenterIndicator.layer.backgroundColor = UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
        self.AllCallCenter.textColor = UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0)
        self.HelplinesTable.reloadData()
        //HelpLinesReaddatafromFirebase()
    }
    
    @IBOutlet weak var AllTestLab: UILabel!
    {
        didSet
        {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AllTestLabTaped))
            AllTestLab.addGestureRecognizer(tapGesture)
            AllTestLab.isUserInteractionEnabled = true
        }
    }
    
    @objc func AllTestLabTaped()
    {
        self.numberState = "test"
        
        //MARK: GEnerate taptic feedback
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
        self.CallCenterIndicator.layer.backgroundColor = UIColor.systemGray3.cgColor
        self.AllCallCenter.textColor = UIColor.systemGray
        self.TestLabIndicator.layer.backgroundColor = UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
        self.AllTestLab.textColor = UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0)
        self.HelplinesTable.reloadData()
      
        //TestlabssReaddatafromFirebase()
    }
     
    //MARK: TabBar Item
    @IBOutlet weak var Statistics : UIImageView!
    
    {
        didSet
        {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(StatisticsTaped))
            Statistics.addGestureRecognizer(tapGesture)
            Statistics.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var Advices : UIImageView!
    {
        didSet{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AdvicesdTaped))
            Advices.addGestureRecognizer(tapGesture)
            Advices.isUserInteractionEnabled = true
        }
    }
    
    @IBOutlet weak var imgSymptoms: UIImageView!{
        didSet {
            
            let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedSymptoms))
            imgSymptoms.addGestureRecognizer(imageTapGestureRecognizer)
            imgSymptoms.isUserInteractionEnabled = true
        }
    }
    
    
    
    //MARK All functions FOr TAbBar
        @objc func StatisticsTaped ()
        {
        
       if golobalData.country == "Bangladesh"
        {performSegue(withIdentifier: "ShowBdData", sender: self)}
        else
        {
            performSegue(withIdentifier: "ShowWorldData", sender: self)}
        
        }
        @objc func AdvicesdTaped()
        {
             performSegue(withIdentifier: "ShowAdvices", sender: self)
        }

        @objc func imageTappedSymptoms() {
            performSegue(withIdentifier: "symptoms", sender: self)
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
           
    @objc func RefreshTableData()
     {
        objTestLAb = []
        objHelpLine = []
        HelpLinesReaddatafromFirebase()
        TestlabssReaddatafromFirebase()
        HelplinesTable.reloadData()
        self.activityIndicator.stopAnimating()
        refresher.endRefreshing()
       
    }
    
    lazy var refresher: UIRefreshControl = {
    let refreshControl   = UIRefreshControl()
        refreshControl.tintColor = UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0)
        refreshControl.addTarget(self, action: #selector(RefreshTableData), for: .valueChanged)
        return refreshControl
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
            
        if #available(iOS 10.0, *)
        {
            HelplinesTable.refreshControl = refresher
        }
        else{
             HelplinesTable.addSubview(refresher)
        }

        TabbarView.layer.masksToBounds = false
        TabbarView.layer.shadowColor =  UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
        TabbarView.layer.shadowOffset = CGSize(width: 1, height: 1)
        TabbarView.layer.shadowRadius = 2
        TabbarView.layer.shadowOpacity = 1
        
        WebSitesReaddatafromFirebase()
         TestlabssReaddatafromFirebase()
        HelpLinesReaddatafromFirebase()
       
       
        
        WebSitesCollections.delegate = self
        WebSitesCollections.dataSource = self
        
        HelplinesTable.delegate = self
        HelplinesTable.dataSource = self
        
    }
    
    
    
    /*func scrollViewDidScroll:(UIScrollView *)scrollView {
        if (scrollView.contentOffset.y > 0) { //20
            [self.navigationController.navigationBar setPrefersLargeTitles:NO];
        } else {
            [self.navigationController.navigationBar setPrefersLargeTitles:YES];
        }
    }
    */
    func WebSitesReaddatafromFirebase()
       {
        self.activityLoader()
           let db = Firestore.firestore()
           db.collection("websites").document("websitesDoc").getDocument { (document, error) in
               
               if error == nil{
                   if document != nil && document!.exists
                   {
                       self.website = (document!.data() as? [String: Array<String>])!
                      
                       self.WebsiteCount = self.website["orgName"]!.count
                       //print(self.WebsiteCount)
                       self.WebSitesCollections.reloadData()
                       //print(self.website)
                   }
               }
           }
       }
   
    func HelpLinesReaddatafromFirebase()
    { activityLoader()
        helplinecollectionRef.getDocuments { (helpline, error) in
            if let err = error {
                print(err)
                 }
        else{
                guard let hlpline = helpline else{ return }
                                     for elemnents in hlpline.documents{
                                         let data = elemnents.data()
                                         let tittle = data["title"] as! String
                                         let numbers = data["number"] as! [String]
                                         let newObjHelpline = helplines(settitle: tittle, setnumber: numbers)
                                         self.objHelpLine.append(newObjHelpline)
                                        self.HelplinesTable.reloadData()
                                     }
                print(self.objHelpLine[2].numbers.count)
                              }
                
        }
         
    }
    
    func TestlabssReaddatafromFirebase()
    {
        activityLoader()
        testlabCollectionRef.getDocuments { (helpline, error) in
            if let err = error {
                print(err)
                 }
        else{
                guard let hlpline = helpline else{ return }
                                     for elemnents in hlpline.documents{
                                         let data = elemnents.data()
                                         let tittle = data["title"] as! String
                                         let numbers = data["number"] as! [String]
                                         let newObjHelpline = helplines(settitle: tittle, setnumber: numbers)
                                         self.objTestLAb.append(newObjHelpline)
                                        self.HelplinesTable.reloadData()
                                     }
                
                              }
                
        }
        
    }
       
    

    
}
