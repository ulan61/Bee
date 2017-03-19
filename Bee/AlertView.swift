//
//  AlertView.swift
//  Bee
//
//  Created by Ulan on 2/27/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import Foundation
import FCAlertView

class AlertView{
    
    static let shared = AlertView()
    
    func show(in viewController: UIViewController,
              withTitle title: String,
              subtitle: String,
              buttonTitle: String) {
        let alert = FCAlertView()

        alert.colorScheme = UIColor.init(netHex: Colors.yellow)
        alert.titleColor = UIColor.init(netHex: Colors.black)
        alert.subTitleColor = UIColor.init(netHex: Colors.black)
        alert.showAlert(inView: viewController,
                        withTitle: title,
                        withSubtitle: subtitle,
                        withCustomImage: UIImage(named: "bee"),
                        withDoneButtonTitle: buttonTitle,
                        andButtons: nil)
    }
    
}
