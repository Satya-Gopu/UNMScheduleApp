//
//  ViewController4.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/23/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class ViewController4: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var subjectArray : [Subjects] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Subject"
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell4", for: indexPath)
        
        cell.textLabel?.text = self.subjectArray[indexPath.row].subjectName
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let five = self.storyboard?.instantiateViewController(withIdentifier: "five") as! ViewController5
        five.courseArray = self.subjectArray[indexPath.row].courseArray
        self.navigationController?.pushViewController(five, animated: true)
    }

    

}
