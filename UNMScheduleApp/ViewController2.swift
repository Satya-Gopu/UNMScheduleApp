//
//  ViewController2.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/22/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var collegeObjectArray : [Campus] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Colleges"
        self.automaticallyAdjustsScrollViewInsets = false
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collegeObjectArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        
        cell.textLabel?.text = collegeObjectArray[indexPath.row].campusname
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let three = self.storyboard?.instantiateViewController(withIdentifier: "three") as! ViewController3
        
        three.departments = self.collegeObjectArray[indexPath.row].collegeArray
        
        self.navigationController?.pushViewController(three, animated: true)
        
    }
    
    
    

    

}
