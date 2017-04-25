//
//  ViewController.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/22/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {
    var selected : Bool = false
    var eName : String = String()
    var positive : Bool = false
    var inside: Bool = false
    var rownumber : Int = 0
    var collegeName : String = ""
    var departmentName : String = ""
    var subjectName : String = ""
    var fname : String = String()
    var lname : String = String()
    var email : String = String()
    var sectionCRN : String = String()
    var partOfTerm : String = String()
    var instructionalMethod : String = String()
    var enrollMax : String = String()
    var enrollNow : String = String()
    var credits : String = String()
    var courseTitle : String = String()
    var coursedescription : String = String()
    var instructorsArray : [Instructors] = []
    var sectionsArray : [Sections] = []
    var courseArray : [Courses] = []
    var departmentArray: [Departments] = []
    var subjectArray : [Subjects] = []
    var collegeObjectArray : [Colleges] = []
    var startTime : String = String()
    var endTime : String = String()
    var day : String = String()
    var daysArray : [Days] = []
    var meetingTimes : [MeetingTimes] = []
    
    @IBOutlet weak var table: UITableView!
    var activityindicator : UIActivityIndicatorView!
    
    var campuses : [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.alpha = 1
        self.navigationItem.title = "Campuses"
        self.automaticallyAdjustsScrollViewInsets = false
    
    }
    override func viewDidAppear(_ animated: Bool) {
        
        self.collegeObjectArray.removeAll()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if selected{
            self.table.alpha = 1
            self.table.isUserInteractionEnabled = true
            self.activityindicator.stopAnimating()
            self.activityindicator.hidesWhenStopped = true
            self.selected = false
            
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return campuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if selected{
            self.table.isUserInteractionEnabled = false
            //cell.contentView.alpha = 0.2
            self.table.alpha = 0.2
        }
        cell.textLabel?.text = campuses[indexPath.row]
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        rownumber = indexPath.row
        self.selected = true
        self.table.reloadData()
        self.activityindicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
        self.activityindicator.center = self.view.center
        self.activityindicator.startAnimating()
        self.view.addSubview(self.activityindicator)
        
        //if let url = Bundle.main.url(forResource: "current", withExtension: "xml"){
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            if let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last?.appendingPathComponent("current.xml"){
                
                let parser = XMLParser(contentsOf: url)
                
                parser?.delegate = self
                parser?.parse()
            }
            let sec = self.storyboard?.instantiateViewController(withIdentifier: "sec") as! ViewController2
            
            sec.collegeObjectArray = self.collegeObjectArray
            
            self.navigationController?.pushViewController(sec, animated: true)
            
        }
        
        
     
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        eName = elementName
        
        
        if ((elementName == "campus") && (attributeDict["name"] == campuses[rownumber])){
            inside = true
        }
        
        if inside {
            
            switch elementName{
                
                case "college":
                    self.collegeName = attributeDict["name"]!
                
                case "department":
                    self.departmentName = attributeDict["name"]!
                
                case "subject":
                    self.subjectName = attributeDict["name"]!
                
                case "course":
                    self.courseTitle = attributeDict["title"]!
                
                case "section":
                    if attributeDict["status"] == "A"{
                        self.positive = true
                        self.sectionCRN = attributeDict["crn"]!
                        self.partOfTerm = attributeDict["part-of-term"]!
                        
                    }
                case "enrollment":
                    self.enrollMax = attributeDict["max"]!
                
                default:
                    break
                
            }
            
            
            
         }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        switch elementName{
            
            case "campus":
                if self.collegeObjectArray.count > 0{
                    parser.abortParsing()
                }
                
                inside = false
            
            case "college":
                if inside {
                    let college = Colleges()
                    college.collname = self.collegeName
                    college.departArray = self.departmentArray
                    self.collegeObjectArray.append(college)
                    self.departmentArray.removeAll()
                    self.collegeName = ""
                 }
            
            case "department":
                if inside {
                    let department = Departments()
                    department.departmentName = self.departmentName
                    department.subjectArray = self.subjectArray
                    self.departmentArray.append(department)
                    self.subjectArray.removeAll()
                    self.departmentName = ""
                }
            
            case "subject":
                if inside {
                    let subject = Subjects()
                    subject.subjectName = self.subjectName
                    subject.courseArray = self.courseArray
                    self.subjectArray.append(subject)
                    self.courseArray.removeAll()
                    self.subjectName = ""
                    
                }
            case "course":
                if inside{
                    let course = Courses()
                    course.title = self.courseTitle
                    course.description = self.coursedescription
                    course.sections = self.sectionsArray
                    self.courseArray.append(course)
                    self.sectionsArray.removeAll()
                    self.courseTitle = ""
                    self.coursedescription = ""
                    
                 }
            case "section":
                if inside && positive{
                    let section = Sections()
                    section.title = self.courseTitle
                    section.partOfTerm = self.partOfTerm
                    section.instructionalMethod = self.instructionalMethod
                    section.enrollmentMax = self.enrollMax
                    section.enrollmentNow = self.enrollNow
                    section.crn = self.sectionCRN
                    section.credits = self.credits
                    section.instructors = self.instructorsArray
                    section.meetingTimes = self.meetingTimes
                    self.sectionsArray.append(section)
                    self.instructorsArray.removeAll()
                    self.meetingTimes.removeAll()
                    self.positive = false
                    self.instructionalMethod = ""
                    self.enrollMax = ""
                    self.enrollNow = ""
                    self.credits = ""
                    
                }
            case "instructor":
                if inside{
                    let instructor = Instructors()
                    instructor.firstName = self.fname
                    instructor.lastName = self.lname
                    instructor.email = self.email
                    self.instructorsArray.append(instructor)
                    self.fname = ""
                    self.lname = ""
                    self.email = ""
                    
                }
            case "days":
                if inside{
                    let days = Days()
                    days.day = self.day
                    self.daysArray.append(days)
                    self.day = ""
                }
            case "meeting-time":
                if inside{
                   let meetingTime = MeetingTimes()
                    meetingTime.days = self.daysArray
                    meetingTime.startTime = self.startTime
                    meetingTime.endTime = self.endTime
                    self.meetingTimes.append(meetingTime)
                    self.startTime = ""
                    self.endTime = ""
                    self.daysArray.removeAll()
                }
            default:
                break
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (!data.isEmpty && inside) {
            
            if eName == "catalog-description"{
                
                self.coursedescription += data
            }
            else if eName == "instructional-method"{
                
                self.instructionalMethod += data
            }
            else if eName == "enrollment"{
                
                self.enrollNow += data
            }
            else if eName == "credits"{
                
                self.credits += data
            }
            else if eName == "first"{
                
                self.fname += data
            }
            else if eName == "last"{
                self.lname += data
                
            }
            else if eName == "email"{
                self.email += data
                
            }
            else if eName == "day"{
                self.day += data
            }
            else if eName == "start-time"{
                self.startTime += data
            }
            else if eName == "end-time"{
                self.endTime += data
            }
        }
    }

    


}

