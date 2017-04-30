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
            
            self.backgroundColor = isSelected ? UIColor.black : UIColor.lightGray
            self.label.textColor = isSelected ? UIColor.white : UIColor.black
        }
        
    }
    
}
