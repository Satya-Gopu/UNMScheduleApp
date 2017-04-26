//
//  CollectionViewCell.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 4/12/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var label: UILabel!
    
    override var isSelected: Bool{
        didSet{
            
            self.backgroundColor = isSelected ? UIColor(red: 1.0, green: 252/255, blue: 174/255, alpha: 1.0) : UIColor.gray
        }
        
    }
    
}
