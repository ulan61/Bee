//
//  VerificationViewController.swift
//  Bee
//
//  Created by Ulan on 2/11/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit
import Alamofire

class VerificationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!    
    @IBOutlet weak var nameTF: UITextField! {
        didSet{
            nameTF.configure(withIcon: FontAwesome.user, iconColor: .white, text: "Ваше имя", textColor: .white,
                             placeholderTextColor: .white, backgroundColor: .clear, borderColor: .white,
                             isLeftView: true)
            nameTF.delegate = self
        }
    }
    @IBOutlet weak var codeTF: UITextField! {
        didSet{
            codeTF.configure(withIcon: FontAwesome.code, iconColor: .white, text: "Полученный код", textColor: .white,
                             placeholderTextColor: .white, backgroundColor: .clear, borderColor: .white, isLeftView: true)
            codeTF.delegate = self
        }
    }
    
    @IBOutlet weak var loginButton: UIButton! {
        didSet{
            loginButton.backgroundColor = .white
            loginButton.setTitle("Войти", for: .normal)
            loginButton.setTitleColor(UIColor.init(netHex: Colors.black), for: .normal)
            loginButton.layer.borderWidth = 1.5
            loginButton.layer.borderColor = UIColor.white.cgColor
            loginButton.titleLabel?.font = UIFont(name: ".SFUIText", size: 18)
            loginButton.setTextSpacing(spacing: 1.0)
        }
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        let tabbarController = UITabBarController()
        navigationController?.viewControllers[0] = tabbarController.setTabbarController()
        UserDefaults.standard.set(true, forKey: "isSignedIn")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(netHex: Colors.yellow)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Keyboard.shared.setObservers(inScrollView: scrollView)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Keyboard.shared.removeObservers(inScrollView: scrollView)
    }
}


//MARK: Helper functions
extension VerificationViewController{
    
    func addTapToScrollView() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self,
                                   action:#selector(UIInputViewController.dismissKeyboard))
        
        scrollView.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        scrollView.endEditing(true)
    }
}
//MARK: UITextFieldDelegate methods

extension VerificationViewController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


