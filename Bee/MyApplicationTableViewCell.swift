//
//  MyApplicationTableViewCell.swift
//  Bee
//
//  Created by Ulan on 2/12/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit

class MyApplicationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var separatorView: UIView! {
        didSet{
            separatorView.backgroundColor = UIColor.init(netHex: Colors.greyBackground)
        }
    }
    
    @IBOutlet weak var serviceLabel:UILabel!{
        didSet{
            serviceLabel.textColor = UIColor.init(netHex: Colors.greyLabelText)
            serviceLabel.font = UIFont(name: ".SFUIText", size: 16)
        }
    }
    @IBOutlet weak var employeeLabel: UILabel!{
        didSet{
            employeeLabel.textColor = UIColor.init(netHex: Colors.yellow)
            employeeLabel.font = UIFont(name: ".SFUIText", size: 18)
        }
    }
    @IBOutlet weak var costLabel: UILabel!{
        didSet{
            costLabel.textColor = .black
            costLabel.font = UIFont.boldSystemFont(ofSize: 19)
        }
    }
    
    var serviceName:String! {
        didSet{
            serviceLabel.text = serviceName
        }
    }
    var employeeName:String! {
        didSet{
            employeeLabel.text = employeeName
        }
    }
    
    var cost: String! {
        didSet{
            costLabel.text = "Итог: " + cost
        }
    }
    
}
