//
//  Colleges.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/22/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import Foundation

class Colleges{
    
    var collname : String = String()
    var departArray : [Departments] = []
    
}

class Departments{
    
    var departmentName : String = String()
    var subjectArray : [Subjects] = []
    
}

class Subjects{
    
    var subjectName: String = String()
    var courseArray : [Courses] = []
    
}

class Courses{
    var title : String = String()
    var description : String = String()
    var sections : [Sections] = []
    
}

class Sections {
    var crn : String = String()
    var title : String = String()
    var partOfTerm : String = String()
    var instructionalMethod : String = String()
    var enrollmentMax : String = String()
    var enrollmentNow : String = String()
    var credits : String = String()
    var instructors : [Instructors] = []
    var meetingTimes : [MeetingTimes] = []
    
}

class Instructors{
    
    var firstName : String = String()
    var lastName : String = String()
    var email : String = String()
    
}


class MeetingTimes{
    
    var days : [Days] = []
    var startTime : String = String()
    var endTime : String = String()
}

class Days{
    var day : String = String()
}

class WeekList{
    var title : String = String()
    var startTime : String = String()
    var endTime = String()
    var days = String()
}
