    //
    //  AdviseViewController.swift
    //  AwareCorona
    //
    //  Created by Meadown on 23/4/20.
    //  Copyright © 2020 Meadown. All rights reserved.
    //
    
    import UIKit
    import Firebase
    
    class Advices {
        
        var adviceTitle : String
        var adviceLink : String
        
        
        init(title: String,link: String) {
            adviceLink = link
            adviceTitle = title
            
        }
        
    }
    
    class AdviseViewController: UIViewController {
        var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        
        var titles : [String] = ["Protect yourself and others", "COVID-19 Home care", "When and how to use MASK ", " Ask WHO"]
        var  protectImages = [
            "section1":[#imageLiteral(resourceName: "blue-2.png"),#imageLiteral(resourceName: "blue-1.png"),#imageLiteral(resourceName: "blue-3.png"),#imageLiteral(resourceName: "blue-4.png")],
            "section2":[#imageLiteral(resourceName: "masks-2.png"),#imageLiteral(resourceName: "masks-3.png"),#imageLiteral(resourceName: "masks-6.png"),#imageLiteral(resourceName: "masks-7.png"),#imageLiteral(resourceName: "masks-5.png"),#imageLiteral(resourceName: "masks-4.png")],
            "section3":[#imageLiteral(resourceName: "home-care-ill-people-square-covid"),#imageLiteral(resourceName: "home-care-everyone-square-covid.png"),#imageLiteral(resourceName: "home-care-caregivers-square-covid")],
            "section4":[#imageLiteral(resourceName: "eng-mythbusting-ncov-(19).png"),#imageLiteral(resourceName: "eng-mythbusting-ncov-(30).png"),#imageLiteral(resourceName: "handshaking.png"),#imageLiteral(resourceName: "eng-mythbusting-ncov-(23).png"),#imageLiteral(resourceName: "eng-mythbusting-ncov-(33).png"),#imageLiteral(resourceName: "eng-mythbusting-ncov-(13).png"),#imageLiteral(resourceName: "safe-greetings.png"),#imageLiteral(resourceName: "wearing-gloves.png")]
        ]
        static var WhichView :  String = "Bd"
        var flag : Bool = false
        var db = Firestore.firestore()
        var advicesCollectionRef = Firestore.firestore().collection("advices")
        var objAdvices = [Advices]()
        
        //MARK: Constraints outlates
        @IBOutlet weak var ScrollVIewTop: NSLayoutConstraint!
        @IBOutlet weak var ScrollViewBottom: NSLayoutConstraint!
        @IBOutlet weak var LargeTextFieldBottom: NSLayoutConstraint!
        @IBOutlet weak var upimageCenterX: NSLayoutConstraint!
        @IBOutlet weak var upimagecenterY: NSLayoutConstraint!
        @IBOutlet weak var lLinkholderviewLeading: NSLayoutConstraint!
        @IBOutlet weak var lLinkholderviewTrailing: NSLayoutConstraint!
        
        //MARK: Ui ITEMS Outlates
        @IBOutlet weak var headerView: UIView!
        @IBOutlet weak var largeTextholderView :UIView!
        @IBOutlet weak var TabbarView:UIView!
        
        @IBOutlet weak var imgAdvicesView: UIImageView!
        
        @IBOutlet weak var largetextfield: UITextView!
        @IBOutlet weak var scrollView: UIScrollView!
        
        @IBOutlet weak var advicesTableview: UITableView!
        
        @IBOutlet var advisesCollectin: UICollectionView!
        @IBOutlet weak var Section2AdvisesCollectin: UICollectionView!
        @IBOutlet weak var Section3CollectionView: UICollectionView!
        @IBOutlet weak var Section4CollectionView: UICollectionView!
        
        //MARK: Cewaring All Ui ITEMS Outlates setion is End
        
        
        //MARK: tapable item outlates and tap gesture setup
        @IBOutlet weak var UpimageView: UIImageView!
            {
            didSet{
                let tapgesture = UITapGestureRecognizer(target: self, action: #selector(upimagetaped))
                UpimageView.addGestureRecognizer(tapgesture)
                UpimageView.isUserInteractionEnabled = true
            }
        }
        @IBOutlet weak var imgStatisticsView: UIImageView!
            {
            didSet {
                let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedStatistics))
                imgStatisticsView.addGestureRecognizer(imageTapGestureRecognizer)
                imgStatisticsView.isUserInteractionEnabled = true
            }
        }
        @IBOutlet weak var imgHelpLineView: UIImageView!
            {
            didSet {
                let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedHelpLine))
                imgHelpLineView.addGestureRecognizer(imageTapGestureRecognizer)
                imgHelpLineView.isUserInteractionEnabled = true
            }
        }
        
        @IBOutlet weak var imgSymptoms: UIImageView!{
                          didSet {
                              
                              let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedSymptoms))
                              imgSymptoms.addGestureRecognizer(imageTapGestureRecognizer)
                              imgSymptoms.isUserInteractionEnabled = true
                          }
                      }
        
        //MARK: All functions are for Navigetion from Current ViewController to other
        @objc func imageTappedStatistics()
        {
            if golobalData.country == "Bangladesh"{
            performSegue(withIdentifier: "ShowBdData", sender: self)}
            else{
                performSegue(withIdentifier: "ShowWorldData", sender: self)
                
            }
            
        }
        @objc func imageTappedHelpLine()
        {
            //helpline
            performSegue(withIdentifier: "helpline", sender: self)
        }
        
        @objc func imageTappedSymptoms() {
            performSegue(withIdentifier: "symptoms", sender: self)
        }
        
        //MARK: Emplementation of All functions are for Navigetion section End
        
        //MARK: fot draging Upimageview over the screen
        @IBAction func viewWasDragged(_ sender: UIPanGestureRecognizer) {
            /*  let translation = sender.translation(in: UpimageView)
             sender.view!.center = CGPoint(x: sender.view!.center.x + translation.x, y: sender.view!.center.y + translation.y)
             sender.setTranslation(CGPoint.zero, in: self.view)
             if sender.state != .cancelled {
             
             }*/
            
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
            AdvicesLinkReaddatafromFirebase()
            setuphome()
            
            advicesTableview.delegate = self
            advicesTableview.dataSource = self
            
            advisesCollectin.delegate = self
            advisesCollectin.dataSource = self
            
        }
        
        //MARK: All Function are for View setup ::
        
        private func setuphome()
        {
            //MARK: UPimageSEtup
            UpimageView.layer.cornerRadius = UpimageView.frame.height/2
            
            //MARK: scrolview top constraint setup
            ScrollVIewTop.constant = UIScreen.main.bounds.height - (50)
            
            //MARK: Upimageview Setup
            ///MARK: UPimage  view constraint
            upimageCenterX.constant = UIScreen.main.bounds.width/2 - 50
            upimagecenterY.constant = UIScreen.main.bounds.height/2 - 120
            ///MARK: UPimage  view layersetup
            UpimageView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
            UpimageView.layer.shadowOffset = CGSize(width: 1, height: 1)
            UpimageView.layer.shadowRadius = 1.4
            UpimageView.layer.shadowOpacity = 0.8
            
            //MARK: Tababr Setup
            TabbarView.layer.masksToBounds = false
            TabbarView.layer.shadowColor =  UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
            TabbarView.layer.shadowOffset = CGSize(width: 1, height: 1)
            TabbarView.layer.shadowRadius = 2
            TabbarView.layer.shadowOpacity = 1
            
            //  roundCorners(with: [.layerMaxXMaxYCorner], radius: 60)
            
            // self.UpimageView.isHidden = true
           // view.bringSubviewToFront(headerView)
            
        }
        
        
        @objc func upimagetaped(){
            //MARK: Function for UpImageView TApEBent
            
            //MARK: Haptic Feedback(Taptic Engine)
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.prepare()
            generator.impactOccurred()
            
            //MARK: cjamging the scrollview constraints with animetion
            if   self.ScrollVIewTop.constant > 80
            {
                
               
                
                ///self.largetextfield.isHidden = true
                self.ScrollVIewTop.constant = 80
               // self.ScrollViewBottom.constant = 50
                UIView.animate(withDuration: 1.0){
                    self.view.layoutIfNeeded()
                }
                
                self.UpimageView.image = UIImage.init(systemName: "chevron.down.circle.fill")
                self.UpimageView.tintColor = UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 0.3)
                UIView.animate(withDuration: 0.5){
                    self.view.layoutIfNeeded()
                }
            }
            else
            {
                
                
               // self.ScrollViewBottom.constant = 0
                self.ScrollVIewTop.constant = UIScreen.main.bounds.height - (50)
                ///  self.largetextfield.isHidden = false
                UIView.animate(withDuration: 1.0){
                    self.view.layoutIfNeeded()
                }
                self.UpimageView.image = UIImage.init(systemName: "circle.grid.hex.fill")
                self.UpimageView.tintColor = UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1)
                
            }
            
           
        }
        
        
        
        func AdvicesLinkReaddatafromFirebase()
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
                        let newobjAdvices = Advices(title: title, link: link)
                        self.objAdvices.append(newobjAdvices)
                        self.advicesTableview.reloadData()
                    }
                    
                }
                
            }
            
        }
        
        
    }
    
