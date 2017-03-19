//
//  ProfileViewController.swift
//  Bee
//
//  Created by Ulan on 2/26/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit
import DigitsKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!{
        didSet{
            nameLabel.text = UserDefaults.standard.string(forKey: "name")
            nameLabel.textColor = .white
        }
    }
    
    @IBOutlet weak var telephoneNumberLabel: UILabel!{
        didSet{
            telephoneNumberLabel.text = UserDefaults.standard.string(forKey: "phoneNumber")
            telephoneNumberLabel.textColor = .white
        }
    }
    
    @IBOutlet weak var logOutButton: UIButton!{
        didSet{
            logOutButton.backgroundColor = .white
            logOutButton.setTitle("Выйти", for: .normal)
            logOutButton.setTitleColor(UIColor.init(netHex: Colors.black), for: .normal)
            logOutButton.setTextSpacing(spacing: 1.0)
            logOutButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        }
    }
    @IBAction func logOut(_ sender: UIButton) {
        guard Internet.isAvailable() else {
            return
        }
        UserDefaults.standard.removeObject(forKey: "isUserRegistered")
        UserDefaults.standard.removeObject(forKey: "isSignedIn")
        _ = self.navigationController?.popViewController(animated: true)
        self.navigationController?.viewControllers[0] = LoginViewController.storyboardInstance()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor(netHex: Colors.yellow)
        self.tabBarController?.navigationItem.title = "Мой профиль"
    }
}
