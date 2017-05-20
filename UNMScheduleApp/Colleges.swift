//
//  Colleges.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/22/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import Foundation

class Semester : NSObject, NSCoding{
    
    var name : String = String()
    var campusArray : [Campus] = []
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "semester") as? String else{
            return
        }
        guard let campuses = aDecoder.decodeObject(forKey: "campusArray") as? [Campus] else{
            return
        }
        self.name = name
        self.campusArray = campuses
    }
    
    override init() {
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "semester")
        aCoder.encode(self.campusArray, forKey: "campusArray")
    }
    
    
}

class Campus : NSObject, NSCoding{
    
    var campusname: String = String()
    var collegeArray : [Colleges] = []
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "campusName") as? String else{
            return
        }
        guard let campuses = aDecoder.decodeObject(forKey: "campuses") as? [Colleges] else{
            return
        }
        
        self.campusname = name
        self.collegeArray = campuses
    }
    
    override init(){
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.campusname, forKey: "campusName")
        aCoder.encode(self.collegeArray, forKey: "campuses")
    }
    
}

class Colleges : NSObject, NSCoding{
    
    var collname : String = String()
    var departArray : [Departments] = []
    
    required init?(coder aDecoder: NSCoder) {
        
        guard let name = aDecoder.decodeObject(forKey: "collName") as? String else{
            return
        }
        guard let deps = aDecoder.decodeObject(forKey: "departments") as? [Departments] else{
            return
        }
        
        self.collname = name
        self.departArray = deps
        
    }
    override init(){
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.collname, forKey: "collName")
        aCoder.encode(self.departArray, forKey: "departments")
    }
    
}

class Departments : NSObject, NSCoding{
    
    var departmentName : String = String()
    var subjectArray : [Subjects] = []
    
    required init?(coder aDecoder: NSCoder) {
        guard let depName = aDecoder.decodeObject(forKey: "depname") as? String else{
            return
        }
        guard let subjects = aDecoder.decodeObject(forKey: "subjects") as? [Subjects] else{
            return
        }
        self.departmentName = depName
        self.subjectArray = subjects
        
    }
    override init(){
        
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.departmentName, forKey: "depname")
        aCoder.encode(self.subjectArray, forKey: "subjects")
    }
    
}

class Subjects : NSObject, NSCoding{
    
    var subjectName: String = String()
    var courseArray : [Courses] = []
    
    required init?(coder aDecoder: NSCoder) {
        guard let name = aDecoder.decodeObject(forKey: "subname") as? String else{
            return
        }
        guard let courses = aDecoder.decodeObject(forKey: "courses") as? [Courses] else{
            return
        }
        self.subjectName = name
        self.courseArray = courses
    }
    override init(){
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.subjectName, forKey: "subname")
        aCoder.encode(self.courseArray, forKey: "courses")
    }
}

class Courses :NSObject, NSCoding{
    var title : String = String()
    var descriptions : String = String()
    var sections : [Sections] = []
    
    required init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: "coursetitle") as? String else{
            return
        }
        guard let description = aDecoder.decodeObject(forKey: "description") as? String else{
            return
        }
        guard let sections = aDecoder.decodeObject(forKey: "sections") as? [Sections] else{
            return
        }
        
        self.title = title
        self.descriptions = description
        self.sections = sections
    }
    override init(){
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "coursetitle")
        aCoder.encode(self.description, forKey: "description")
        aCoder.encode(self.sections, forKey: "sections")
    }
    
    
    
}

class Sections : NSObject, NSCoding{
    var crn : String = String()
    var title : String = String()
    var partOfTerm : String = String()
    var instructionalMethod : String = String()
    var enrollmentMax : String = String()
    var enrollmentNow : String = String()
    var credits : String = String()
    var instructors : [Instructors] = []
    var meetingTimes : [MeetingTimes] = []
    
    required init?(coder aDecoder: NSCoder) {
        
        guard let crn = aDecoder.decodeObject(forKey: "crn") as? String, let title = aDecoder.decodeObject(forKey: "sectiontitle") as? String else{
            return
        }
        guard let partOfTerm = aDecoder.decodeObject(forKey: "term") as? String else{
            return
        }
        guard let instructionalMethod = aDecoder.decodeObject(forKey: "method") as? String else{
            return
        }
        guard let enrollmax = aDecoder.decodeObject(forKey: "max") as? String else{
            return
        }
        guard let enrollmin = aDecoder.decodeObject(forKey: "min") as? String else{
            return
        }
        guard let credits = aDecoder.decodeObject(forKey: "credits") as? String else{
            return
        }
        guard let instructors = aDecoder.decodeObject(forKey: "instructors") as? [Instructors] else{
            return
        }
        guard let meetingTimes = aDecoder.decodeObject(forKey: "meetingTimes") as? [MeetingTimes] else{
            return
        }
        
        self.crn = crn
        self.title = title
        self.partOfTerm = partOfTerm
        self.instructionalMethod = instructionalMethod
        self.enrollmentMax = enrollmax
        self.enrollmentNow = enrollmin
        self.credits = credits
        self.instructors = instructors
        self.meetingTimes = meetingTimes
        
        
    }
    override init(){
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.title, forKey: "sectiontitle")
        aCoder.encode(self.crn, forKey: "crn")
        aCoder.encode(self.partOfTerm, forKey: "term")
        aCoder.encode(self.instructionalMethod, forKey: "method")
        aCoder.encode(self.enrollmentMax, forKey: "max")
        aCoder.encode(self.enrollmentNow, forKey: "min")
        aCoder.encode(self.credits, forKey: "credits")
        aCoder.encode(self.instructors, forKey: "instructors")
        aCoder.encode(self.meetingTimes, forKey: "meetingTimes")
    }
    
    
}

class Instructors : NSObject, NSCoding{
    
    var firstName : String = String()
    var lastName : String = String()
    var email : String = String()
    
    required init?(coder aDecoder: NSCoder) {
        guard let firstName = aDecoder.decodeObject(forKey: "firstName") as? String,
              let lastName = aDecoder.decodeObject(forKey: "lastName") as? String,
            let email = aDecoder.decodeObject(forKey: "email") as? String else{
                
                return
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
    override init(){
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.firstName, forKey: "firstName")
        aCoder.encode(self.lastName, forKey: "lastName")
        aCoder.encode(self.email, forKey: "email")
    }
    
}


class MeetingTimes:NSObject, NSCoding{
    
    var days : [Days] = []
    var startTime : String = String()
    var endTime : String = String()
    
    required init?(coder aDecoder: NSCoder) {
        guard let days = aDecoder.decodeObject(forKey: "daysArray") as? [Days], let startTime = aDecoder.decodeObject(forKey: "startTime") as? String, let endTime = aDecoder.decodeObject(forKey: "endTime") as? String else{
            return
        }
        
        self.days = days
        self.startTime = startTime
        self.endTime = endTime
    }
    override init(){
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.days, forKey: "daysArray")
        aCoder.encode(self.startTime, forKey: "startTime")
        aCoder.encode(self.endTime, forKey: "endTime")
    }
    
    
    
    
}

class Days : NSObject, NSCoding{
    
    var day : String = String()
    
    required init?(coder aDecoder: NSCoder) {
        guard let day = aDecoder.decodeObject(forKey: "day") as? String else {
            return
        }
        self.day = day
    }
    override init(){
        
    }
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.day, forKey: "day")
    }
    
    
    
}

class WeekList{
    var title : String = String()
    var section : Sections!
    var startTime : String = String()
    var endTime = String()
    var days = String()
    var crn : String = String()
    var instructionalMethod : String = String()
}
