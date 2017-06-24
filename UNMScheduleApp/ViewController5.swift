//
//  ViewController5.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/23/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class ViewController5: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    var subjectArray = [Subjects]()
    var courseArray : [Courses] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "courses"
        self.automaticallyAdjustsScrollViewInsets = false
        for subject in subjectArray{
            courseArray.append(contentsOf: subject.courseArray)
        }
        subjectArray = subjectArray.sorted(by: {(sub1, sub2) in
            return sub1.subjectName < sub2.subjectName
        })
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return subjectArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectArray[section].courseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell5", for: indexPath)
        
        cell.textLabel?.text = subjectArray[indexPath.section].courseArray[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return subjectArray[section].subjectName
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let six = self.storyboard?.instantiateViewController(withIdentifier: "six") as! ViewController6
        six.coursetitle = subjectArray[indexPath.section].courseArray[indexPath.row].title
        //self.courseArray[indexPath.row].title
        six.descriptions = subjectArray[indexPath.section].courseArray[indexPath.row].descriptions
            //self.courseArray[indexPath.row].descriptions
        six.sections = subjectArray[indexPath.section].courseArray[indexPath.row].sections
            //self.courseArray[indexPath.row].sections
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
                    weekView.crn = section.crn
                    weekView.instructionalMethod = section.instructionalMethod
                    for days in section.meetingTimes[0].days{
                        
                        weekView.days.append(days.day)
                        
                    }
                    weekView.section = section
                    week.weekView.append(weekView)
                }
                
            }
            
        }
        
        let nav = UINavigationController(rootViewController: week)
        
        self.present(nav, animated: true, completion: nil)
        
    }
    
    

    

}
