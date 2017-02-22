//
//  CCHexagonCollectionViewCell.swift
//  Bee
//
//  Created by Ulan on 2/3/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit

class CCHexagonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    var iconImage: UIImage! {
        didSet{
            iconImageView.image = iconImage
        }
        
    }
    
    var text: String! {
        didSet{
            textLabel.text = text
        }
    }    
}
