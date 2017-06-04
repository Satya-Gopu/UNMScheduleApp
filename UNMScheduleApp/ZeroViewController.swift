//
//  ZeroViewController.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 3/2/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class ZeroViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var lists = [0 : ["Albuquerque/Main", "Albq Westside (UNM West)", "Online & ITV", "San Juan Bachelors/Graduate"], 1 : ["Gallup", "Gallup Bachelors/Graduate"], 2 : ["Taos", "Taos Bachelors/Graduate", "Taos/Mora", "Taos/Ojo Caliente"], 3 : ["Los Alamos"], 4 : ["Valencia"]]
    
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var fileURL : URL!
    var semester : Semester!
    var semester1 : Semester!
    var semester2 : Semester!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if UserDefaults.standard.bool(forKey: "visited") != true{
            let nonvisited = self.storyboard?.instantiateViewController(withIdentifier: "initial") as! InitialViewController
            present(nonvisited, animated: true, completion: nil)
            
        }
        else{
            
            self.semester1 = NSKeyedUnarchiver.unarchiveObject(withFile: self.appDelegate.fileURL.appendingPathComponent("current").path) as! Semester
            self.semester = semester1
            self.semester2 = NSKeyedUnarchiver.unarchiveObject(withFile: self.appDelegate.fileURL.appendingPathComponent("next").path) as! Semester
            self.presentAlert(semester1: semester1.name, semester2: semester2.name)
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
            //self.fileURL = self.appDelegate.fileURL.appendingPathComponent("next1.xml")
            print(self.fileURL)
            self.dismiss(animated: true, completion: nil)
        })
        alert.addAction(nextAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
