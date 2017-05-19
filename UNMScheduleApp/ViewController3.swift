//
//  ViewController3.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 2/22/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class ViewController3: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var departments : [Colleges] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Departments"
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return departments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell3", for: indexPath)
        cell.textLabel?.text = self.departments[indexPath.row].collname
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let four = self.storyboard?.instantiateViewController(withIdentifier: "four") as! ViewController4
        
        //four.subjectArray = self.departments[indexPath.row].subjectArray
        
        self.navigationController?.pushViewController(four, animated: true)
        
        
        
        
    }

    

}
