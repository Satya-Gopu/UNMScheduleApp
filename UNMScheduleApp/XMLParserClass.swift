//
//  XMLParserClass.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 5/18/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import Foundation

class XMLParserClass : NSObject, XMLParserDelegate{
   
    var fileURL : URL!
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
    var campusName : String = ""
    var campusArray : [Campus] = []
    var parserError : Error!
    
    
    init(url : URL){
        
        self.fileURL = url
    }
    
    func startParsing(){
        
        let parser = XMLParser(contentsOf: self.fileURL)
        parser?.delegate = self as XMLParserDelegate
        parser?.parse()
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        eName = elementName
        
        switch elementName{
        case "campus":
            self.campusName = attributeDict["name"]!
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
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        switch elementName{
            
        case "campus":
            let campus = Campus()
            campus.campusname = self.campusName
            campus.collegeArray = self.collegeObjectArray
            self.campusArray.append(campus)
            self.collegeObjectArray.removeAll()
            self.campusName = ""
            
            
        case "college":
            let college = Colleges()
            college.collname = self.collegeName
            college.departArray = self.departmentArray
            self.collegeObjectArray.append(college)
            self.departmentArray.removeAll()
            self.collegeName = ""
            
        case "department":
            let department = Departments()
            department.departmentName = self.departmentName
            department.subjectArray = self.subjectArray
            self.departmentArray.append(department)
            self.subjectArray.removeAll()
            self.departmentName = ""
            
        case "subject":
            let subject = Subjects()
            subject.subjectName = self.subjectName
            subject.courseArray = self.courseArray
            self.subjectArray.append(subject)
            self.courseArray.removeAll()
            self.subjectName = ""
            
        case "course":
            
            let course = Courses()
            course.title = self.courseTitle
            course.descriptions = self.coursedescription
            course.sections = self.sectionsArray
            self.courseArray.append(course)
            self.sectionsArray.removeAll()
            self.courseTitle = ""
            self.coursedescription = ""
            
        case "section":
            if positive{
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
            let instructor = Instructors()
            instructor.firstName = self.fname
            instructor.lastName = self.lname
            instructor.email = self.email
            self.instructorsArray.append(instructor)
            self.fname = ""
            self.lname = ""
            self.email = ""
            
        case "days":
            let days = Days()
            days.day = self.day
            self.daysArray.append(days)
            self.day = ""
            
        case "meeting-time":
            let meetingTime = MeetingTimes()
            meetingTime.days = self.daysArray
            meetingTime.startTime = self.startTime
            meetingTime.endTime = self.endTime
            self.meetingTimes.append(meetingTime)
            self.startTime = ""
            self.endTime = ""
            self.daysArray.removeAll()
            
        default:
            break
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            
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
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        self.parserError = parseError
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("end of document")
    }
    
    
}
