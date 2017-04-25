//
//  ViewController7.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/24/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class ViewController7: UIViewController {
    
    
    @IBOutlet weak var crnlabel: UILabel!
    
    @IBOutlet weak var instructionaltype: UILabel!
    
    @IBOutlet weak var partofterm: UILabel!
    
    @IBOutlet weak var coursetitle: UILabel!
    @IBOutlet weak var maxenrolllabel: UILabel!
    
    @IBOutlet weak var nowenrolllabel: UILabel!
    
    
    @IBOutlet weak var creditslabel: UILabel!
    
    
    @IBOutlet weak var instructorlabel: UILabel!
    
    
    @IBOutlet weak var emaillabel: UILabel!
    
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
        self.crnlabel.text = self.crn
        self.coursetitle.text = self.titles
        self.partofterm.text = self.partOfTerm
        self.instructionaltype.text = self.instructType
        self.maxenrolllabel.text = self.enrollmentMax
        self.nowenrolllabel.text = self.enrollmentNow
        self.creditslabel.text = self.credits
        self.instructorlabel.text = self.instructors[0].firstName +  " " + self.instructors[0].lastName
        self.emaillabel.text = self.instructors[0].email
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.navigationItem.rightBarButtonItem?.title = "StartOver"
        //self.navigationItem.rightBarButtonItem.
        
    }
    
    
    

    

}
