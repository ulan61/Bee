//
//  DescriptionViewController.swift
//  Bee
//
//  Created by Ulan on 2/9/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController {
    
    var address: String!
    var telephoneNumber: String!
    var serviceDescription:String!
    
    @IBOutlet weak var descriptionTextView: UITextView! {
        didSet{
            descriptionTextView.text = serviceDescription
        }
    }
    
    @IBOutlet weak var addressLabel:UILabel!{
        didSet{
            addressLabel.font = UIFont.fontAwesome(ofSize: 17)
            addressLabel.text = FontAwesome.place + "   \(address!)"
        }
    }
    @IBOutlet weak var telephoneLabel: UILabel! {
        didSet{
            telephoneLabel.font = UIFont.fontAwesome(ofSize: 17)
            telephoneLabel.text = FontAwesome.phone + "  \(telephoneNumber!)"
        }
    }
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        let contentSize = descriptionTextView.sizeThatFits(descriptionTextView.bounds.size)
        var frame = descriptionTextView.frame
        frame.size.height = contentSize.height
        descriptionTextView.frame = frame
        
        let aspectRatioTextViewConstraint = NSLayoutConstraint(item: descriptionTextView, attribute: .height, relatedBy: .equal, toItem: descriptionTextView, attribute: .width, multiplier: descriptionTextView.bounds.height/descriptionTextView.bounds.width, constant: 1)
        descriptionTextView.addConstraint(aspectRatioTextViewConstraint)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.init(netHex: Colors.greyBackground)
    }
}
