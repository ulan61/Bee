//
//  ServicesTableViewCell.swift
//  Bee
//
//  Created by Ulan on 2/19/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit

class ServicesTableViewCell: UITableViewCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = .white
    }
    
    @IBOutlet weak var label:UILabel! {
        didSet{
            label.font = UIFont(name: ".SFUIText", size: 18)
            label.textColor = UIColor.init(netHex: Colors.black)
        }
    }
    @IBOutlet weak var thinCircle: UILabel!{
        didSet{
            thinCircle.font = UIFont.fontAwesome(ofSize: 18)
            thinCircle.text = FontAwesome.thinCicle
            thinCircle.textColor = UIColor.init(netHex: Colors.yellow)
        }
    }
    
    @IBOutlet weak var circle: UILabel!{
        didSet{
            circle.font = UIFont.fontAwesome(ofSize: 10)
            circle.text = ""
            circle.textColor = UIColor.init(netHex: Colors.yellow)
        }
    }
    var employeeName: String! {
        didSet{
            label.text = employeeName
        }
    }
    
    var serviceSelected: Bool! {
        didSet{
            if !serviceSelected{
                circle.text = ""
            }
            else{
                circle.text = FontAwesome.circle
            }
        }
    }
}
