//
//  SearchViewController.swift
//  Bee
//
//  Created by Ulan on 2/16/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
            scrollView.isScrollEnabled = true
            print(scrollView.gestureRecognizers!)
        }
    }
    
    var serviceDescription: String!
    var cost: String!
    
    @IBOutlet weak var descriptionTextView: UITextView!{
        didSet{
            descriptionTextView.text = serviceDescription
        }
    }
    
    @IBOutlet weak var costLabel: UILabel!{
        didSet{
            costLabel.text = cost + " сом"
        }
    }
    
    @IBOutlet weak var addCostLabel: UILabel!
    
    @IBOutlet weak var summaryLabel: UILabel!
    
    @IBOutlet weak var increaseButton: UIButton!{
        didSet{
            increaseButton.titleLabel?.font = UIFont.fontAwesome(ofSize: 16)
            increaseButton.setTitle(FontAwesome.up + " Повысить ставку", for: .normal)
            increaseButton.setTitleColor(.white, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Поиск специалистов"
        self.view.backgroundColor = UIColor.init(netHex: Colors.greyBackground)
    }
}

