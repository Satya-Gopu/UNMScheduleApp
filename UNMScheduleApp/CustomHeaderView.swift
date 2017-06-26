//
//  CustomHeaderView.swift
//  UNMScheduleApp
//
//  Created by Satyanarayana Gopu on 6/26/17.
//  Copyright © 2017 Appfish. All rights reserved.
//

import UIKit

protocol CustomHeaderViewDelegate{
    
    func toggleSection(header : UITableViewHeaderFooterView, section : Int)
    
}

class CustomHeaderView: UITableViewHeaderFooterView {

    var delegate : CustomHeaderViewDelegate?
    var section : Int!
    var imageView = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor.lightGray
        textLabel?.textColor = UIColor(colorLiteralRed: 161, green: 132, blue: 5, alpha: 1)
    }
    
    func customInit(title : String, section : Int, delegate : CustomHeaderViewDelegate){
        self.delegate = delegate
        self.section = section
        self.textLabel?.text = title
        
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectHeaderAction(gesture : UITapGestureRecognizer){
        let header = gesture.view as! CustomHeaderView
        delegate?.toggleSection(header: header, section: header.section)
        
    }
}
