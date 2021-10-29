    //
    //  WorldViewController.swift
    //  AwareCorona
    //
    //  Created by Meadown on 23/4/20.
    //  Copyright © 2020 Meadown. All rights reserved.
    //
    
    import UIKit
    import PieCharts
    class WorldViewController: UIViewController {
        
        //MARK: constraint outlates
        @IBOutlet weak var CountryPickerHolderTop: NSLayoutConstraint!
        @IBOutlet weak var DoneViewHeight: NSLayoutConstraint!
        
        //MARK:All view
        @IBOutlet weak var mainview: UIView!
        @IBOutlet weak var CountryView: UIView!
        @IBOutlet weak var Newdata: UIView!
        @IBOutlet weak var Totaldata: UIView!
        @IBOutlet weak var chartView: PieChart!
        @IBOutlet weak var ncdataView: UIView!
        @IBOutlet weak var nddataview: UIView!
        @IBOutlet weak var nCaseView: UIView!
        @IBOutlet weak var nDathView: UIView!
        @IBOutlet weak var headerview: UIView!
        @IBOutlet weak var TabbarView: UIView!
        @IBOutlet weak var countryPickerHolderView: UIView!
        @IBOutlet weak var DoneView: UIView!
        @IBOutlet weak var imgBangladesh: UIImageView!
        @IBOutlet weak var imgWorld: UIImageView!
        //MARK: pickerView
        @IBOutlet weak var CountryPicker: UIPickerView!
        
        //MARK:- Inside tod=taldata view in TotalDatalayerstack all views layouts
        @IBOutlet weak var TotalAffectedView: UIView!
        @IBOutlet weak var TotalDeathVIew: UIView!
        @IBOutlet weak var TotalRecoveredView: UIView!
        @IBOutlet weak var TotalTestView: UIView!
        
        //MARK: lbls that show the api value
        
        @IBOutlet weak var lblnNewAffected: UILabel!
        @IBOutlet weak var lblNewDeaths: UILabel!
        @IBOutlet weak var lblTotalAffected: UILabel!
        @IBOutlet weak var lblTotadeaths: UILabel!
        @IBOutlet weak var lblTotalRecovered: UILabel!
        @IBOutlet weak var lblTotalTest: UILabel!
        @IBOutlet weak var lblLastUpdateTimeStamp: UILabel!
        
        
        //MARK: Items For select country from picjer view
        @IBOutlet weak var lblDone: UILabel!
            {
            didSet {
                let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedCountrySelect))
                lblDone.addGestureRecognizer(imageTapGestureRecognizer)
                lblDone.isUserInteractionEnabled = true
            }
        }
        
        @IBOutlet weak var lblSelectedCountry: UILabel!
            {
            didSet {
                let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedCountrySelect))
                lblSelectedCountry.addGestureRecognizer(imageTapGestureRecognizer)
                lblSelectedCountry.isUserInteractionEnabled = true
            }
        }
        
        //MARK: Items for Custom tabbar
        @IBOutlet weak var imgSelect_country: UIImageView!
            {
            didSet {
                let imageTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTappedCountrySelect))
                imgSelect_country.addGestureRecognizer(imageTapGestureRecognizer)
                imgSelect_country.isUserInteractionEnabled = true
            }
        }
        
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
        
        //MARK: All objc funtions for selector
        ///tabbar items selector funtion
        @objc func imageTappedBangladesh() {
            self.performSegue(withIdentifier: "BangladeshData", sender: self)
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
        
        ///select country item selector function
        @objc func imageTappedCountrySelect() {
            
            if CountryPickerHolderTop.constant == 0
            {
                CountryPicker.isHidden = false
                DoneViewHeight.constant = 35
                CountryPickerHolderTop.constant = -250
                UIView.animate(withDuration: 0.5){
                    self.view.layoutIfNeeded()
                }
                
            }
            else{
                CountryPicker.isHidden = true
                DoneViewHeight.constant = 0
                CountryPickerHolderTop.constant = 0
                UIView.animate(withDuration: 0.5){
                    self.view.layoutIfNeeded()
                }
            }
            
            
        }
        
        
        //MARK: ALL class  Varible
        var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
        var pickerData : [String] = []
        
        
        
        override func viewDidLoad() {
            
            super.viewDidLoad()
            //MARK: While View load necessary FUNCTION CALL:
            SetupView()
            loadCountryName()
            loadData()
            
            //MARK: picker view deleget and datasource setting
            CountryPicker.delegate = self
            CountryPicker.dataSource = self
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
        
        func SetupView(){
            lblSelwctedCountrydValueChanged()
            
            countryPickerHolderView.layer.cornerRadius = 20
            countryPickerHolderView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            DoneView.layer.cornerRadius = 20
            DoneView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            
            
            //MARK: Countrpickerviewshadow
            CountryPicker.layer.masksToBounds = false
            //TabbarView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
            CountryPicker.layer.shadowColor =  UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
            CountryPicker.layer.shadowOffset = CGSize(width: 1, height: 1)
            CountryPicker.layer.shadowRadius = 2
            CountryPicker.layer.shadowOpacity = 1
            
            
            //MARK: Tababr Setup
            TabbarView.layer.masksToBounds = false
            //TabbarView.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
            TabbarView.layer.shadowColor =  UIColor(red:31/255.0, green:110/255.0, blue:100/255.0, alpha: 1.0).cgColor
            TabbarView.layer.shadowOffset = CGSize(width: 1, height: 1)
            TabbarView.layer.shadowRadius = 2
            TabbarView.layer.shadowOpacity = 1
            
            
            //MARK: Headerview SETUP:
            headerview.layer.cornerRadius = 30
            headerview.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            
            //MARK: Country View SETUP:
            CountryView.layer.cornerRadius = 20
            CountryView.layer.masksToBounds = true
            
            //MARK: Newdata view SETUP:
            Newdata.layer.cornerRadius = 20
            Newdata.layer.masksToBounds = false
            Newdata.layer.shadowColor =  UIColor(red:0/255.0, green:0/255.0, blue:0/255.0, alpha: 1.0).cgColor
            Newdata.layer.shadowOffset = CGSize(width: 1, height: 1)
            Newdata.layer.shadowRadius = 3
            Newdata.layer.shadowOpacity = 0.6
            
            //MARK: Inside newdata nCaseview SETUP:
            nCaseView.layer.cornerRadius = 10
            
            //  nCaseView.layer.borderWidth = 1
            // nCaseView.layer.borderColor = UIColor(red:255/255, green:204/255, blue:0/255, alpha: 1).cgColor
            
            //MARK: Inside newdata nDeathsview SETUP:
            nDathView.layer.cornerRadius = 10
            
            // nDathView.layer.borderWidth = 1
            // nDathView.layer.borderColor = UIColor(red:255/255, green:59/255, blue:48/255, alpha: 1).cgColor
            
            //MARK: Totaldata view SETUP
            Totaldata.layer.cornerRadius = 20
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
            
            // TotalTestView.layer.cornerRadius = 10
            // TotalTestView.layer.masksToBounds = true
            
            // Flug.image = UIImage.gif(asset: "bangladesh-flug")
            // Flug.layer.cornerRadius = Flug.frame.size.width/2
            
        }
        
        func PieChartSetup(affected : Int, deaths : Int, recovered : Int){
            chartView.models = [
                PieSliceModel(value: Double(affected), color: UIColor.systemYellow),//total affected
                PieSliceModel(value: Double(deaths), color: UIColor.systemRed),//total deaths
                PieSliceModel(value: Double(recovered), color: UIColor.systemGreen),//total recovered
                //  PieSliceModel(value: Double(test), color: UIColor.systemTeal) //total test
            ]
            
        }
        
        func loadData() {
            
            let surl = "https://covid-193.p.rapidapi.com/statistics?country=\(golobalData.country)"
            let request = APICall.getData(surl: surl)
            let session = URLSession.shared
            
            activityLoader()
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error)
                    self.lblNewDeaths.text? = "--"
                    self.lblnNewAffected.text? = "--"
                    self.lblTotadeaths.text? = "--"
                    self.lblTotalAffected.text? = "--"
                    self.lblTotalRecovered.text? = "--"
                    
                    self.PieChartSetup(affected: 0 , deaths: 0, recovered: 0)
                } else {
                    let httpResponse = response as? HTTPURLResponse
                    print(httpResponse)
                    guard let data = data else { return }
                    do{
                        let bddata = try JSONDecoder().decode(BdData.self, from: data)
                        
                        DispatchQueue.main.async {
                            
                            if (bddata.parameters?.country)! as String != "bddata.parameters?.country"
                            {
                                self.lblNewDeaths.text? = ("\((bddata.response?[0].deaths?.new) ?? "0")")
                                self.lblnNewAffected.text? = ("\((bddata.response?[0].cases?.new) ?? "0")")
                                self.lblTotadeaths.text? = ("\((bddata.response?[0].deaths?.total)!)")
                                self.lblTotalAffected.text? = ("\((bddata.response?[0].cases?.total)!)")
                                self.lblTotalRecovered.text? = ("\((bddata.response?[0].cases?.recovered)!)")
                                self.lblLastUpdateTimeStamp.text? = self.formettime(time: ("\((bddata.response?[0].time)!)"))
                                
                                self.PieChartSetup(affected: (bddata.response?[0].cases?.total)! , deaths: (bddata.response?[0].deaths?.total)!, recovered: (bddata.response?[0].cases?.recovered)!)
                                
                                self.activityIndicator.stopAnimating()
                            }
                            
                        }
                        
                    }catch{
                        print(error)
                        DispatchQueue.main.async {
                            self.lblNewDeaths.text? = "--"
                            self.lblnNewAffected.text? = "--"
                            self.lblTotadeaths.text? = "--"
                            self.lblTotalAffected.text? = "--"
                            self.lblTotalRecovered.text? = "--"
                            
                            self.PieChartSetup(affected: 0 , deaths: 0, recovered: 0)
                            
                        }
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
                self.CountryPicker.reloadAllComponents()
                
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
        
        
        //MARK: make the lblCountry selected text World if all selected
        func lblSelwctedCountrydValueChanged() {
            if golobalData.country == "All"
            {
                lblSelectedCountry.text = "World"
                
            }
            else{
                lblSelectedCountry.text = golobalData.country
            }
        }
        
        
        
    }
