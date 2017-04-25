//
//  WeekViewController2.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 4/25/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class WeekViewController2: UIViewController {
    
    
    
    @IBOutlet weak var sectionTitle: UILabel!
    
    @IBOutlet weak var crn: UILabel!
    
    
    @IBOutlet weak var days: UILabel!
    
    
    @IBOutlet weak var time: UILabel!
    
    
    @IBOutlet weak var instruction: UILabel!
    
    
    var weeklist : WeekList!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        // Do any additional setup after loading the view.
        
        self.crn.text = self.weeklist.crn
        self.time.text = self.weeklist.startTime + " - " + self.weeklist.endTime
        self.sectionTitle.text = self.weeklist.title
        self.days.text = self.weeklist.days
        self.instruction.text = self.weeklist.instructionalMethod
        
        let item = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(done))
        self.navigationItem.setRightBarButton(item, animated: true)
        self.navigationItem.title = "Detail view"
    }

    @IBAction func done(){
        
        dismiss(animated: true, completion: nil)
        
    }

}
