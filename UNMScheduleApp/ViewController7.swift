//
//  ViewController7.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/24/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import SafariServices

class ViewController7: UIViewController {
    var section : Sections!
    @IBOutlet weak var crnlabel: UILabel!
    @IBOutlet weak var instructionaltype: UILabel!
    @IBOutlet weak var partofterm: UILabel!
    @IBOutlet weak var coursetitle: UILabel!
    @IBOutlet weak var maxenrolllabel: UILabel!
    @IBOutlet weak var nowenrolllabel: UILabel!
    @IBOutlet weak var creditslabel: UILabel!
    @IBOutlet weak var instructorlabel: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var register: UIButton!
    @IBOutlet weak var days: UILabel!
    @IBOutlet weak var crnHeaderLabel: UILabel!
    @IBOutlet weak var maxEnrollHeaderLabel: UILabel!
    @IBOutlet weak var currentEnrollHeaderLabel: UILabel!
    @IBOutlet weak var instructionalHeaderLabel: UILabel!
    @IBOutlet weak var daysHeaderLabel: UILabel!
    @IBOutlet weak var emailHeaderLabel: UILabel!
    @IBOutlet weak var instructorHeaderLabel: UILabel!
    @IBOutlet weak var timeHeaderLabel: UILabel!
    @IBOutlet weak var creditsHeaderLabel: UILabel!
    @IBOutlet weak var partOfTermLabel: UILabel!
    
    
    var titles : String = String()
    var crn : String = String()
    var enrollmentMax : String = String()
    var enrollmentNow : String = String()
    var credits : String = String()
    var partOfTerm : String = String()
    var instructType : String = String()
    var instructors : [Instructors] = []
    
    

    override func viewDidLoad() {
        crnlabel.layer.borderColor = UIColor.black.cgColor
        crnlabel.layer.borderWidth = 3
        instructionaltype.layer.borderColor = UIColor.black.cgColor
        instructionaltype.layer.borderWidth = 3
        partofterm.layer.borderColor = UIColor.black.cgColor
        partofterm.layer.borderWidth = 3
        maxenrolllabel.layer.borderColor = UIColor.black.cgColor
        maxenrolllabel.layer.borderWidth = 3
        nowenrolllabel.layer.borderColor = UIColor.black.cgColor
        nowenrolllabel.layer.borderWidth = 3
        creditslabel.layer.borderColor = UIColor.black.cgColor
        creditslabel.layer.borderWidth = 3
        instructorlabel.layer.borderColor = UIColor.black.cgColor
        instructorlabel.layer.borderWidth = 3
        emaillabel.layer.borderColor = UIColor.black.cgColor
        emaillabel.layer.borderWidth = 3
        timing.layer.borderColor = UIColor.black.cgColor
        timing.layer.borderWidth = 3
        days.layer.borderColor = UIColor.black.cgColor
        days.layer.borderWidth = 3
        crnHeaderLabel.layer.borderColor = UIColor.black.cgColor
        crnHeaderLabel.layer.borderWidth = 3
        maxEnrollHeaderLabel.layer.borderColor = UIColor.black.cgColor
        maxEnrollHeaderLabel.layer.borderWidth = 3
        currentEnrollHeaderLabel.layer.borderColor = UIColor.black.cgColor
        currentEnrollHeaderLabel.layer.borderWidth = 3
        instructorHeaderLabel.layer.borderColor = UIColor.black.cgColor
        instructorHeaderLabel.layer.borderWidth = 3
        daysHeaderLabel.layer.borderColor = UIColor.black.cgColor
        daysHeaderLabel.layer.borderWidth = 3
        emailHeaderLabel.layer.borderColor = UIColor.black.cgColor
        emailHeaderLabel.layer.borderWidth = 3
        instructionalHeaderLabel.layer.borderColor = UIColor.black.cgColor
        instructionalHeaderLabel.layer.borderWidth = 3
        timeHeaderLabel.layer.borderColor = UIColor.black.cgColor
        timeHeaderLabel.layer.borderWidth = 3
        creditsHeaderLabel.layer.borderColor = UIColor.black.cgColor
        creditsHeaderLabel.layer.borderWidth = 3
        partOfTermLabel.layer.borderColor = UIColor.black.cgColor
        partOfTermLabel.layer.borderWidth = 3
        super.viewDidLoad()
        self.register.layer.cornerRadius = 3.0
        self.crnlabel.text = self.section.crn == "" ? "not availabale" : self.section.crn
        self.coursetitle.text = self.section.title  == "" ? "not available" : self.section.title
        self.partofterm.text = self.section.partOfTerm == "" ? "not available" : self.section.partOfTerm
        self.instructionaltype.text = self.section.instructionalMethod == "" ? "not available" : self.section.instructionalMethod
        self.maxenrolllabel.text = self.section.enrollmentMax == "" ? "not available" : self.section.enrollmentMax
        self.nowenrolllabel.text = self.section.enrollmentNow == "" ? "not available" : self.section.enrollmentNow
        self.creditslabel.text = self.section.credits == "" ? "not available" : self.section.credits
        if !(section.instructors.isEmpty){
            self.instructorlabel.text = self.section.instructors[0].firstName +  " " + self.section.instructors[0].lastName
            self.emaillabel.text = self.section.instructors[0].email
        }else{
            self.instructorlabel.text = "not available"
            self.emaillabel.text = "not available"
        }
        if !(section.meetingTimes.isEmpty){
            for day in section.meetingTimes[0].days{
                self.days.text?.append(day.day)
            }
            self.timing.text = section.meetingTimes[0].startTime + " - " + section.meetingTimes[0].endTime
            
        }
        else{
            
            self.days.text = "not available"
            self.timing.text = "not available"
        }
        self.automaticallyAdjustsScrollViewInsets = false
        let rightItem = UIBarButtonItem(title: "StartOver", style: .plain, target: self, action: #selector(popToRoot))
        self.navigationItem.setRightBarButton(rightItem, animated: true)
        
    }
    
    func popToRoot(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func openSafari(_ sender: Any) {
        let url = URL(string: "https://login.unm.edu/cas/login?service=https%3a%2f%2fmy.unm.edu%2fdashboard")
        let svc = SFSafariViewController(url: url!)
        self.present(svc, animated: true, completion: nil)
    }

}
