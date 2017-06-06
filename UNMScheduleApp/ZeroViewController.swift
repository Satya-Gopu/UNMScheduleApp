//
//  ZeroViewController.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 3/2/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import Foundation

class ZeroViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, URLSessionDelegate{
    
    var lists = [0 : ["Albuquerque/Main", "Albq Westside (UNM West)", "Online & ITV", "San Juan Bachelors/Graduate"], 1 : ["Gallup", "Gallup Bachelors/Graduate"], 2 : ["Taos", "Taos Bachelors/Graduate", "Taos/Mora", "Taos/Ojo Caliente"], 3 : ["Los Alamos"], 4 : ["Valencia"]]
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var fileURL : URL!
    var executed  = false
    var semester : Semester!
    var semester1 : Semester!
    var semester2 : Semester!
    lazy var session : URLSession = {[unowned self]  in
        
        let config = URLSessionConfiguration.default
        //config.httpMaximumConnectionsPerHost = 1
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
        
        }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        if UserDefaults.standard.bool(forKey: "visited") != true{
            let nonvisited = self.storyboard?.instantiateViewController(withIdentifier: "initial") as! InitialViewController
            self.present(nonvisited, animated: true, completion: nil)
        }
        else{
            self.semester1 = NSKeyedUnarchiver.unarchiveObject(withFile: self.appDelegate.fileURL.appendingPathComponent("current").path) as! Semester
            self.semester = semester1
            self.semester2 = NSKeyedUnarchiver.unarchiveObject(withFile: self.appDelegate.fileURL.appendingPathComponent("next").path) as! Semester
            let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeup))
            swipeGesture.direction = UISwipeGestureRecognizerDirection.up
            self.view.addGestureRecognizer(swipeGesture)
            executed = true
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "visited") == true{
            //self.presentAlert(semester1: semester1.name, semester2: semester2.name)
            if let date = UserDefaults.standard.object(forKey: "lastUpdateOn") as? Date{
                let timeInterval = Date().timeIntervalSince(date)
                if timeInterval >= 86400{
                    print("More than a day ago")
                 }
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if UserDefaults.standard.bool(forKey: "visited") == true && !executed{
            self.semester1 = NSKeyedUnarchiver.unarchiveObject(withFile: self.appDelegate.fileURL.appendingPathComponent("current").path) as! Semester
            self.semester = semester1
            self.semester2 = NSKeyedUnarchiver.unarchiveObject(withFile: self.appDelegate.fileURL.appendingPathComponent("next").path) as! Semester
            executed = true
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func swipeup(){
        
        self.presentAlert(semester1: semester1.name, semester2: semester2.name)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "zero", for: indexPath)
        cell.textLabel?.text = lists[indexPath.row]?[0]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let first = self.storyboard?.instantiateViewController(withIdentifier: "first") as! ViewController
        first.campuses = self.lists[indexPath.row]!
        first.campusArray = self.semester.campusArray
        self.navigationController?.pushViewController(first, animated: true)
        
    }
    func presentAlert(semester1: String, semester2: String){
        let alert = UIAlertController(title: "Please select a semester", message: nil, preferredStyle: .actionSheet)
        let currentAction = UIAlertAction(title: semester1, style: .default, handler: { action in
            self.semester = self.semester1
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(currentAction)
        let nextAction = UIAlertAction(title: semester2, style: .default, handler: { action in
            self.semester = self.semester2
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(nextAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
