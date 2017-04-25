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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        
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
        self.navigationController?.pushViewController(first, animated: true)
        
    }
    
    

    

}
