//
//  ViewController5.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/23/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class ViewController5: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var courseArray : [Courses] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "courses"
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return courseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath)
        
        cell.textLabel?.text = courseArray[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let six = self.storyboard?.instantiateViewController(withIdentifier: "six") as! ViewController6
        six.coursetitle = self.courseArray[indexPath.row].title
        six.descriptions = self.courseArray[indexPath.row].description
        six.sections = self.courseArray[indexPath.row].sections
        self.navigationController?.pushViewController(six, animated: true)
        
    }
    
    
    @IBAction func pickWeekView(_ sender: AnyObject) {
        
        let week = self.storyboard?.instantiateViewController(withIdentifier: "week") as! WeekViewController
        
        for course in self.courseArray{
            
            for section in course.sections{
                
                if !(section.meetingTimes.isEmpty){
                    let weekView = WeekList()
                    weekView.title = course.title
                    weekView.startTime = section.meetingTimes[0].startTime
                    weekView.endTime = section.meetingTimes[0].endTime
                    for days in section.meetingTimes[0].days{
                        
                        weekView.days.append(days.day)
                        
                    }
                    week.weekView.append(weekView)
                }
                
            }
            
        }
        
        self.present(week, animated: true, completion: nil)
        
    }
    
    

    

}
