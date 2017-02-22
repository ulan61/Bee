//
//  DescriptionViewController.swift
//  Bee
//
//  Created by Ulan on 2/9/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var address: String! {
        didSet{
            addressLabel.text = FontAwesome.place + "   \(address!)"
        }
    }
    var telephoneNumber: String! {
        didSet{
            telephoneLabel.text = FontAwesome.phone + "  \(telephoneNumber!)"
        }
    }
    
    @IBOutlet weak var addressLabel:UILabel!{
        didSet{
            addressLabel.font = UIFont.fontAwesome(ofSize: 17)
        }
    }
    @IBOutlet weak var telephoneLabel: UILabel! {
        didSet{
            telephoneLabel.font = UIFont.fontAwesome(ofSize: 17)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(netHex: Colors.greyBackground)
        
        address = "11 микрорайон, дом 20, кв 94"
        
        telephoneNumber = "0 700 888 353"
    }
}
