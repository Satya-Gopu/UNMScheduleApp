//
//  ViewController6.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/24/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class ViewController6: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var label: UILabel!
    
    var descriptions : String = String()
    var coursetitle : String = String()
    var sections : [Sections] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Details"
        label.text = self.descriptions
        titlelabel.text = self.coursetitle
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "six", for: indexPath)
        
        cell.textLabel?.text = "Course with CRN - \(sections[indexPath.row].crn)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let seven = self.storyboard?.instantiateViewController(withIdentifier: "seven") as! ViewController7
        seven.crn = self.sections[indexPath.row].crn
        seven.titles = self.sections[indexPath.row].title
        seven.partOfTerm = self.sections[indexPath.row].partOfTerm
        seven.instructType = self.sections[indexPath.row].instructionalMethod
        seven.enrollmentMax = self.sections[indexPath.row].enrollmentMax
        seven.enrollmentNow = self.sections[indexPath.row].enrollmentNow
        seven.credits = self.sections[indexPath.row].credits
        seven.instructors = self.sections[indexPath.row].instructors
        self.navigationController?.pushViewController(seven, animated: true)
        
    }

    

}
