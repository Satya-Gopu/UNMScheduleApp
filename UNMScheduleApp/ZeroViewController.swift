//
//  ZeroViewController.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 3/2/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit
import Foundation

class ZeroViewController: UIViewController{
    
    var lists = [0 : ["Albuquerque/Main", "Albq Westside (UNM West)", "Online & ITV", "San Juan Bachelors/Graduate"], 1 : ["Gallup", "Gallup Bachelors/Graduate"], 2 : ["Taos", "Taos Bachelors/Graduate", "Taos/Mora", "Taos/Ojo Caliente"], 3 : ["Los Alamos"], 4 : ["Valencia"]]
    var listss = [Section(title : "Albuquerque/Main", subCampuses : ["Albuquerque/Main", "Albq Westside (UNM West)", "Online & ITV", "San Juan Bachelors/Graduate"], expanded : false ), Section(title : "Gallup", subCampuses : ["Gallup", "Gallup Bachelors/Graduate"], expanded : false ), Section(title : "Taos", subCampuses : ["Taos", "Taos Bachelors/Graduate", "Taos/Mora", "Taos/Ojo Caliente"], expanded : false ), Section(title : "Los Alamos", subCampuses : ["Los Alamos"], expanded : false ), Section(title : "Valencia", subCampuses : ["Valencia"], expanded : false )]
    @IBOutlet weak var settingsView: UIView!
    @IBOutlet weak var trailingLayout: NSLayoutConstraint!
    @IBOutlet weak var barImage: UIBarButtonItem!
    @IBOutlet weak var cellularDataSwitch: UISwitch!
    @IBOutlet weak var table: UITableView!
    var filesDownloaded : Int = 0
    var sessionInProgress = false
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var executed  = false
    var semester : Semester!
    var semester1 : Semester!
    var semester2 : Semester!
    
    override func viewDidLoad() {
        cellularDataSwitch.isOn = UserDefaults.standard.bool(forKey: "cellular")
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        trailingLayout.constant = -self.settingsView.bounds.width
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
            print("visited")
            if let date = UserDefaults.standard.object(forKey: "lastUpdateOn") as? Date{
                print("calling")
                let timeInterval = Date().timeIntervalSince(date)
                if timeInterval >= 86740{
                    self.runcode()
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
    
    @IBAction func cellularValueChanged(_ sender: Any) {
        
        UserDefaults.standard.set(cellularDataSwitch.isOn, forKey: "cellular")
    }
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if let touch = touches.first, touch.view != self.settingsView{
            
            UIView.animate(withDuration: 0.5, animations: {
                self.trailingLayout.constant = -self.settingsView.bounds.width
                self.table.isUserInteractionEnabled = true
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBAction func openSeetings(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, animations: {
            if self.trailingLayout.constant < 0{
                self.trailingLayout.constant = 0
                self.table.isUserInteractionEnabled = false
            }else{
                self.trailingLayout.constant = -self.settingsView.bounds.width
                self.table.isUserInteractionEnabled = true
                self.view.alpha = 1
            }
            
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        
        
        
    }
    
    func runcode(){
        
        if !sessionInProgress{
            sessionInProgress = true
            let configuration = URLSessionConfiguration.background(withIdentifier: "task")
            configuration.allowsCellularAccess = cellularDataSwitch.isOn
            let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
            let urlrequest = URLRequest(url: self.appDelegate.remoteURLCurrent!)
            let downloadtask = session.downloadTask(with: urlrequest)
            downloadtask.resume()
            
            let urlrequest2 = URLRequest(url: self.appDelegate.remoteURLNext!)
            let downloadtask2 = session.downloadTask(with: urlrequest2)
            downloadtask2.resume()
            
        }
    }
    
    @IBAction func swipeup(){
        self.presentAlert(semester1: semester1.name, semester2: semester2.name)
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

extension ZeroViewController : URLSessionDelegate, URLSessionDownloadDelegate{
    
    func urlSessionDidFinishEvents(forBackgroundURLSession session: URLSession) {
        
        if let completion = appDelegate.completionForBackGround{
            
            DispatchQueue.main.async {
                completion()
            }
            
            
        }
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("downloaded to \(location)")
        filesDownloaded += 1
        let parser = XMLParserClass(url: location)
        parser.startParsing()
        if let semester = parser.semester{
            if downloadTask.originalRequest?.url?.lastPathComponent == "current.xml"{
                self.semester1 = semester
                NSKeyedArchiver.archiveRootObject(semester, toFile: self.appDelegate.fileURL.appendingPathComponent("current").path)
                
            }
            else{
                self.semester2 = semester
                NSKeyedArchiver.archiveRootObject(semester, toFile: self.appDelegate.fileURL.appendingPathComponent("next").path)
                
                
            }
            
            if filesDownloaded >= 2{
                filesDownloaded = 0
                session.finishTasksAndInvalidate()
            }
        }
        
        
    }
    
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: Error?) {
        if error == nil{
            print("session invalidated successfully")
            UserDefaults.standard.set(Date(), forKey: "lastUpdateOn")
            sessionInProgress = false
        }
        
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if let error = error{
            
            print(error.localizedDescription)
            
        }
        
        
    }
    
}


extension ZeroViewController: UITableViewDelegate, UITableViewDataSource{
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listss.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listss[section].subCampuses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "zero", for: indexPath)
        cell.textLabel?.text = listss[indexPath.section].subCampuses[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sec = self.storyboard?.instantiateViewController(withIdentifier: "sec") as! ViewController2
        for campus in semester.campusArray{
            if listss[indexPath.section].subCampuses[indexPath.row] == campus.campusname{
                sec.collegeObjectArray = campus.collegeArray
            }
            
        }
        self.navigationController?.pushViewController(sec, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if listss[indexPath.section].expanded{
            return 44
        }
        else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = CustomHeaderView()
        view.customInit(title : listss[section].title, section: section, delegate: self)
        return view
    }
    
}

extension ZeroViewController : CustomHeaderViewDelegate{
    
    func toggleSection(header: UITableViewHeaderFooterView, section: Int) {
        listss[section].expanded = !listss[section].expanded
        table.beginUpdates()
        
        for i in 0..<listss[section].subCampuses.count{
            table.reloadRows(at: [IndexPath(row : i, section : section)], with: .automatic)
            
        }
        table.endUpdates()
    }
    
}
