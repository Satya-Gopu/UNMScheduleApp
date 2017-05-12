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
    
    var titles : String = String()
    var crn : String = String()
    var enrollmentMax : String = String()
    var enrollmentNow : String = String()
    var credits : String = String()
    var partOfTerm : String = String()
    var instructType : String = String()
    var instructors : [Instructors] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.register.layer.cornerRadius = 3.0
        self.register.setTitleColor(UIColor.red, for: .selected)
        //self.register.setBackgroundImage(UIImage(UIColor.black), for: .selected)
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
        
        self.navigationItem.rightBarButtonItem?.title = "StartOver"
        //self.navigationItem.rightBarButtonItem.
        
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
