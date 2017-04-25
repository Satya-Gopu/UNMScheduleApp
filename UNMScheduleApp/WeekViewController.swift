//
//  WeekViewController.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 4/12/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class WeekViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var weekView : [WeekList] = []
    var selectDefault : Bool!
    var selectedList : [WeekList] = []
    
    var array1 = ["Mon":"M","Tue":"T","Wed":"W","Thu":"R","Fri":"F"]
    var arr = ["Mon", "Tue", "Wed", "Thu", "Fri"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.selectDefault = true
        // Do any additional setup after loading the view.
        for week in weekView{
            
            if week.days.contains("M"){
                
                self.selectedList.append(week)
                
            }
            
        }

    }
    
    
    
    @IBAction func doneAction(_ sender: AnyObject) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.label.text = arr[indexPath.row]
        print(self.selectDefault)
        print(indexPath.row)
        if indexPath.row == 0 && self.selectDefault{
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition:.centeredVertically)
            self.selectDefault = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CollectionViewCell
        
        for week in weekView{
            
            if week.days.contains(self.array1[cell.label.text!]!){
                
                self.selectedList.append(week)
                
            }
            
        }
        
        self.selectedList.sort(by: {(course1 : WeekList, course2 : WeekList) in
            return course1.startTime < course2.startTime
        })
        
        self.table.reloadData()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.selectedList.removeAll()
    }


}

extension WeekViewController : UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.selectedList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tablecell", for: indexPath)
        cell.textLabel!.text = self.selectedList[indexPath.row].title
        cell.detailTextLabel?.text = "Timing : " + self.selectedList[indexPath.row].startTime + " - " + self.selectedList[indexPath.row].endTime
        return cell
    }
    
}

extension WeekViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let avail = self.view.frame.width/5
        
        return CGSize(width: avail, height: 53.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
