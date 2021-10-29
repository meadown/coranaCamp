    //
    //  ViewController.swift
    //  AwareCorona
    //
    //  Created by Meadown on 20/4/20.
    //  Copyright © 2020 Meadown. All rights reserved.
    //
    
    import UIKit
    import Foundation
    import PieCharts
    //import PieSliceDelegate
    class BDViewController: UIViewController{
        
       var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        
        //MARKS: Constraints Outlate
        @IBOutlet weak var CountryPickerHolderTop: NSLayoutConstraint!
        @IBOutlet weak var DoneViewHeight: NSLayoutConstraint!
        
        
        
        //MARK: all necessary outlets
        @IBOutlet weak var mainview: UIView!
        @IBOutlet weak var CountryView: UIView!
        @IBOutlet weak var Newdata: UIView!
        @IBOutlet weak var Totaldata: UIView!
        @IBOutlet weak var chartView: PieChart!
        @IBOutlet weak var newRecoveredView: UIView!
        @IBOutlet weak var newTestView: UIView!
        @IBOutlet weak var newAffectdView: UIView!
        @IBOutlet weak var newDathView: UIView!
        @IBOutlet weak var headerview: UIView!
        @IBOutlet weak var TabbarView: UIView!
        @IBOutlet weak var newdataviews: UIView!
        @IBOutlet weak var Flug: UIImageView!
        
        //MARK:- Inside tod=taldata view in TotalDatalayerstack all views layouts
        @IBOutlet weak var TotalAffectedView: UIView!
        @IBOutlet weak var TotalDeathVIew: UIView!
        @IBOutlet weak var TotalRecoveredView: UIView!
        @IBOutlet weak var TotalTestView: UIView!
      
        //MARK: CollectionViewdata
        public weak var delegate: PieChartDelegate?
        
        //MARK: lbls that show the api value
        @IBOutlet weak var lblnNewAffected: UILabel!
        @IBOutlet weak var lblNewDeaths: UILabel!
        @IBOutlet weak var lblNewRecovered: UILabel!
        @IBOutlet weak var lblNewTests: UILabel!
        
        @IBOutlet weak var lblTotalAffected: UILabel!
        @IBOutlet weak var lblTotadeaths: UILabel!
        @IBOutlet weak var lblTotalRecovered: UILabel!
        @IBOutlet weak var lblTotalTest: UILabel!
        
        //MARK: Custom tabbar images outlets
        @IBOutlet weak var imgBangladesh: UIImageView!
        @IBOutlet weak var imgWorld: UIImageView!
        @IBOutlet weak var imgAdvise: UIImageView! {
            didSet {
                let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedAdvise))
                imgAdvise.addGestureRecognizer(imageTapGestureRecognizer)
                imgAdvise.isUserInteractionEnabled = true
            }
        }
        @IBOutlet weak var imgHelpLine: UIImageView!{
            didSet {
                
                let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedHelpLine))
                imgHelpLine.addGestureRecognizer(imageTapGestureRecognizer)
                imgHelpLine.isUserInteractionEnabled = true
            }
        }
        
        @IBOutlet weak var imgSymptoms: UIImageView!{
                          didSet {
                              
                              let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedSymptoms))
                              imgSymptoms.addGestureRecognizer(imageTapGestureRecognizer)
                              imgSymptoms.isUserInteractionEnabled = true
                          }
                      }
               
        //MARK: custom Tabbar codes to segue between Views
        @objc func imageTappedWorld() {
            self.performSegue(withIdentifier: "WorldData", sender: self)
        }
        @objc func imageTappedAdvise() {
            self.performSegue(withIdentifier: "Advise", sender: self)
        }
        @objc func imageTappedHelpLine() {
            self.performSegue(withIdentifier: "HelpLine", sender: self)
        }
        @objc func imageTappedSymptoms() {
            self.performSegue(withIdentifier: "symptoms", sender: self)
        }
        
        
        
        
        //MARK: Work for picker view
        @IBOutlet weak var CountrySelectView: UIView!
        @IBOutlet weak var DoneView: UIView!
        @IBOutlet weak var CountrySelectPickerView: UIPickerView!
        @IBOutlet weak var lblDone: UILabel!
            {
            didSet {
                let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedCountrySelect))
                lblDone.addGestureRecognizer(imageTapGestureRecognizer)
                lblDone.isUserInteractionEnabled = true
            }
        }
        @IBOutlet weak var lblUptadeTimeStamp: UILabel!
        @IBOutlet weak var lblSelectedCountry: UILabel!
            {
            didSet {
                let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedCountrySelect))
                lblSelectedCountry.addGestureRecognizer(imageTapGestureRecognizer)
                lblSelectedCountry.isUserInteractionEnabled = true
            }
        }
        @IBOutlet weak var imgSelect_country: UIImageView!
            {
            didSet{
                let imgTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedCountrySelect))
                imgSelect_country.addGestureRecognizer(imgTapGestureRecognizer)
                imgSelect_country.isUserInteractionEnabled = true
                
            }
        }
        
        
        @objc func imageTappedCountrySelect()
        {
            if CountryPickerHolderTop.constant == 0
            {
                CountrySelectPickerView.isHidden = false
                DoneViewHeight.constant = 35
                CountryPickerHolderTop.constant = -250
                
                UIView.animate(withDuration: 0.5){
                    self.view.layoutIfNeeded()
                }
                
            }
            else{
                CountrySelectPickerView.isHidden = true
                DoneViewHeight.constant = 0
                CountryPickerHolderTop.constant = 0
                
                UIView.animate(withDuration: 0.5){
                    self.view.layoutIfNeeded()
                }
            }
            
            
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
        
        var pickerData : [String] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            //MARK: Set counrty
            golobalData.country = "Bangladesh"
            //MARK: While View load necessary FUNCTION CALL:
            SetupView()
            loadData()
            loadCountryName()
            print(golobalData.FormatedCurrentTime())
            //MARK:For CollectionView necessary propertis SETUP:
            
            CountrySelectPickerView.delegate = self
            CountrySelectPickerView.dataSource = self
            
            print(golobalData.country)
            
        }
        
        
        func SetupView(){
            
            
            //MARK: Headerview SETUP:
            headerview.layer.cornerRadius = 30
            headerview.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            
            CountrySelectView.layer.cornerRadius = 20
            CountrySelectView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            DoneView.layer.cornerRadius = 20
            DoneView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            
            //MARK: Countrpickerviewshadow
            CountrySelectView.layer.masksToBounds = false
            //TabbarView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
            CountrySelectView.layer.shadowColor =  UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
            CountrySelectView.layer.shadowOffset = CGSize(width: 1, height: 1)
            CountrySelectView.layer.shadowRadius = 2
            CountrySelectView.layer.shadowOpacity = 1
            
            
            //MARK: Tababr Setup
            TabbarView.layer.masksToBounds = false
            //TabbarView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
            TabbarView.layer.shadowColor =  UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
            TabbarView.layer.shadowOffset = CGSize(width: 1, height: 1)
            TabbarView.layer.shadowRadius = 2
            TabbarView.layer.shadowOpacity = 1
            
            
            //MARK: Country View SETUP:
            CountryView.layer.cornerRadius = 20
            CountryView.layer.masksToBounds = true
            
            //MARK: Newdata view SETUP:
            Newdata.layer.cornerRadius = 10
            Newdata.layer.masksToBounds = false
            Newdata.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
            Newdata.layer.shadowOffset = CGSize(width: 1, height: 1)
            Newdata.layer.shadowRadius = 3
            Newdata.layer.shadowOpacity = 0.6
            
            //MARK: inside newdata views corner redious SETUP
            newDathView.layer.cornerRadius = 10
            newAffectdView.layer.cornerRadius = 10
            newRecoveredView.layer.cornerRadius = 10
            newTestView.layer.cornerRadius = 10
            
            
            //MARK: Totaldata view SETUP
            Totaldata.layer.cornerRadius = 10
            Totaldata.layer.masksToBounds = false
            Totaldata.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
            Totaldata.layer.shadowOffset = CGSize(width: 1, height: 1)
            Totaldata.layer.shadowRadius = 3
            Totaldata.layer.shadowOpacity = 0.6
            
            //MARK: All views Inside TotalDatalayerstack Corner Radious SETUP
            TotalAffectedView.layer.cornerRadius = 10
            TotalAffectedView.layer.masksToBounds = true
            
            TotalDeathVIew.layer.cornerRadius = 10
            TotalDeathVIew.layer.masksToBounds = true
            
            TotalRecoveredView.layer.cornerRadius = 10
            TotalRecoveredView.layer.masksToBounds = true
            
            TotalTestView.layer.cornerRadius = 10
            TotalTestView.layer.masksToBounds = true
            
            // Flug.image = UIImage.gif(asset: "bangladesh-flug")
            // Flug.layer.cornerRadius = Flug.frame.size.width/2
            
            
        }
        
        func PieChartSetup(affected : Int, deaths : Int, recovered : Int, test : Int){
            chartView.models = [
                PieSliceModel(value: Double(affected), color: UIColor.systemYellow),//total affected
                PieSliceModel(value: Double(deaths), color: UIColor.systemRed),//total deaths
                PieSliceModel(value: Double(recovered), color: UIColor.systemGreen),//total recovered
                PieSliceModel(value: Double(test), color: UIColor.systemTeal) //total test
            ]
            
        }
        
        
        func loadData() {
            
           
            let surl = "https://covid-193.p.rapidapi.com/history?day=\(golobalData.getToday())&country=bangladesh"
            let request = APICall.getData(surl: surl)
            let session = URLSession.shared
            activityLoader()
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    
                    print(error)
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse)
                    guard let data = data else { return }
                    do{
                        let bddata = try JSONDecoder().decode(BdData.self, from: data)
                        
                        DispatchQueue.main.async {
                            if  bddata.response!.count != 0{
                            self.lblUptadeTimeStamp.text? = self.formettime(time: ("\((bddata.response?[0].time)!)"))
                            self.lblNewDeaths.text? = ("\((bddata.response?[0].deaths?.new) ?? "0")")
                            self.lblnNewAffected.text? = ("\((bddata.response?[0].cases?.new) ?? "0")")
                            print("--------------------------")
                            print(bddata.response?.count)
                            if bddata.response!.count > 1
                            {
                                self.getNewRecoveredBd(value:(bddata.response?[0].tests?.total)!,value2:(bddata.response?[1].tests?.total)!,Which: 1, type:"tests")
                                self.getNewRecoveredBd(value:(bddata.response?[0].cases?.recovered)!,value2:(bddata.response?[1].cases?.recovered)!,Which: 1, type:"recovered")
                            }
                            else
                            {
                                self.getNewRecoveredBd(value:(bddata.response?[0].tests?.total)!,value2: 0,Which: 1, type:"tests")
                                self.getNewRecoveredBd(value:(bddata.response?[0].cases?.recovered)!,value2: 0,Which: 1, type:"recovered")
                            }
                            
                            
                            self.lblTotadeaths.text? = ("\((bddata.response?[0].deaths?.total)!)")
                            self.lblTotalAffected.text? = ("\((bddata.response?[0].cases?.total)!)")
                            self.lblTotalRecovered.text? = ("\((bddata.response?[0].cases?.recovered)!)")
                            if (bddata.response?[0].tests?.total) != nil
                            {
                                self.lblTotalTest.text? = ("\((bddata.response?[0].tests?.total)!)")
                                
                            }
                            else
                            {
                                self.lblTotalTest.text? = "Not Found"
                            }
                            
                            //Mark: Set piecharts value
                            self.PieChartSetup(affected: (bddata.response?[0].cases?.total)! , deaths: (bddata.response?[0].deaths?.total)!, recovered: (bddata.response?[0].cases?.recovered)!, test: bddata.response?[0].tests?.total ?? 0)
                            
                        
                              
                    }
                        else{
                            self.lodalldata()
                        }
                        
                        }
                          
                    }catch{
                        print(error)
                    }
                }
               
            })
            dataTask.resume()
        }
        
        func lodalldata(){
            let surl = "https://covid-193.p.rapidapi.com/statistics?country=bangladesh"
            let request = APICall.getData(surl: surl)
            let session = URLSession.shared
            
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse)
                    guard let data = data else { return }
                    do{
                        let bddata = try JSONDecoder().decode(BdData.self, from: data)
                        
                        DispatchQueue.main.async {
                            self.lblUptadeTimeStamp.text? = self.formettime(time: ("\((bddata.response?[0].time)!)"))
                            self.lblNewDeaths.text? = ("\((bddata.response?[0].deaths?.new) ?? "0")")
                            self.lblnNewAffected.text? = ("\((bddata.response?[0].cases?.new) ?? "0")")
                            print("--------------------------")
                            print(bddata.response?.count)
                           
                                self.getNewRecoveredBd(value:(bddata.response?[0].tests?.total)!,value2: 0,Which: 2, type:"tests")
                                self.getNewRecoveredBd(value:(bddata.response?[0].cases?.recovered)!,value2: 0,Which: 2, type:"recovered")
                            
                            
                            
                            self.lblTotadeaths.text? = ("\((bddata.response?[0].deaths?.total)!)")
                            self.lblTotalAffected.text? = ("\((bddata.response?[0].cases?.total)!)")
                            self.lblTotalRecovered.text? = ("\((bddata.response?[0].cases?.recovered)!)")
                            if (bddata.response?[0].tests?.total) != nil
                            {
                                self.lblTotalTest.text? = ("\((bddata.response?[0].tests?.total)!)")
                                
                            }
                            else
                            {
                                self.lblTotalTest.text? = "Not Found"
                            }
                            
                            //Mark: Set piecharts value
                            self.PieChartSetup(affected: (bddata.response?[0].cases?.total)! , deaths: (bddata.response?[0].deaths?.total)!, recovered: (bddata.response?[0].cases?.recovered)!, test: bddata.response?[0].tests?.total ?? 0)
                            
                        }
                        
                    }catch{
                        print(error)
                    }
                }
            })
            dataTask.resume()
        }
        
        
        func getNewRecoveredBd(value:Int,value2 : Int ,Which:Int,type:String)
        {
            var number : Int = 0
              
            let surl = "https://covid-193.p.rapidapi.com/history?day=\(golobalData.getYesterday())&country=Bangladesh"
            let request = APICall.getData(surl: surl)
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse)
                    guard let data = data else { return }
                    do{
                        let bddata = try JSONDecoder().decode(BdData.self, from: data)
                        
                        if bddata.response!.count > 0 {
                        DispatchQueue.main.async {
                            if type == "recovered"
                            {
                                if Which == 1{
                                 number =  (bddata.response?[0].cases?.recovered)!
                                }
                                else{
                                number =  (bddata.response?[1].cases?.recovered)!
                                }
                                
                                if  value2 == 0{
                                    self.lblNewRecovered.text? = "+\(value - number)"
                                    
                                }
                                else{
                                    self.lblNewRecovered.text? = "+\(value - value2)"
                                }
                                
                                
                            }
                            else
                            {
                               
                                if Which == 1{
                                 number =  (bddata.response?[0].tests?.total)!
                                }
                                else{
                                    number =  (bddata.response?[1].tests?.total)!
                                }
                                // self.lblNewTests.text? = "+\(value - number)"
                                if value2 == 0
                                {
                                    self.lblNewTests.text? = "+\(value - number)"
                                    
                                }
                                else{
                                    self.lblNewTests.text? = "+\(value - value2)"
                                }
                                
                            }
                             self.activityIndicator.stopAnimating()
                        }
                        }else {
                            print ("data.found")
                            DispatchQueue.main.async {
                            self.activityIndicator.stopAnimating()
                            }
                        }
                    }catch{
                        print(error)
                    }
                }
            })
            dataTask.resume()
        }
        
        func loadCountryName()
        {
             let objCountries = countries()
                       DispatchQueue.main.async {
                           
                           self.pickerData.append(contentsOf: objCountries.countries as [String])
                           self.CountrySelectPickerView.reloadAllComponents()
                           
                       }
        }
        
        
        func formettime(time: String) -> String
        {
            let dateFormatterGet = DateFormatter()
            dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            
            let dateFormatterPrint = DateFormatter()
            dateFormatterPrint.dateFormat = "MMM dd,yy"
            
            let timeFormatterPrint = DateFormatter()
            timeFormatterPrint.dateFormat = "h:mm a"
            //  timeFormatterPrint.timeZone = TimeZone.init(identifier: "UTC+06:00")
            
            if let date = dateFormatterGet.date(from: String(time)){
                
                print(date)
                print(dateFormatterPrint.string(from: date) + " | " + timeFormatterPrint.string(from: date) )
                return dateFormatterPrint.string(from: date) + " | " + timeFormatterPrint.string(from: date)
            } else {
                print("There was an error decoding the string")
                return ""
            }
        }
        
        
        
        
    } //MARK: ----------------------------- ViewDidLoad END
    
    
