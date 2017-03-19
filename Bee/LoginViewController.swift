//
//  ViewController.swift
//  Bee
//
//  Created by Ulan on 1/30/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit
import SwiftMaskTextfield
import DigitsKit


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    static func storyboardInstance() -> UIViewController{
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        return loginViewController
    }
    
    
    var isUserRegistered: Bool! {
        didSet{
            UserDefaults.standard.set(isUserRegistered, forKey: "isUserRegistered")
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var conView: UIView! {
        didSet{
            let userDef = UserDefaults.standard
            if userDef.bool(forKey: "isUserRegistered") == true {
                conView.alpha = 1
            }
            else{
                conView.alpha = 0
            }
        }
    }
    
    @IBOutlet weak var textField: SwiftMaskTextField!{
        didSet{
            textField.configure(withIcon: FontAwesome.phone, iconColor: .white, text: "Номер телефона",
                                textColor: .white, placeholderTextColor: .white, backgroundColor: .clear,
                                borderColor: .white, isLeftView: true)
            textField.delegate = self
            textField.formatPattern = "# (###) ##-##-##"
            textField.keyboardType = UIKeyboardType.decimalPad
        }
    }
    @IBOutlet weak var sendButton: UIButton!{
        didSet{
            sendButton.setTitle("ОТПРАВИТЬ", for: .normal)
            sendButton.setTextSpacing(spacing: 1.0)
        }
    }
    
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!
    
    @IBAction func send(_ sender: UIButton) {
        
        guard Internet.isAvailable() else {
            AlertView.shared.show(in: self, withTitle: "Проблема с соединением", subtitle: "Убедитесь, что Вы подключены к интенету", buttonTitle: "OK")
            return
        }
        
        guard textField.isRightTelephoneNumber() else {
            AlertView.shared.show(in: self, withTitle: "Неправильный номер", subtitle: "Пожалуйста, убедитесь в правильности набранного номера", buttonTitle: "ОК")
            return
        }
        activityIndicator.startAnimating()
        sender.setTitle("", for: .normal)
        sender.isEnabled = false
        let number = textField.text!
        textField.resignFirstResponder()
        UIApplication.shared.statusBarStyle = .default
        let numberWithoutZero = "\(Int(number.getDigits())!)"
        let digits = Digits.sharedInstance()
        digits.logOut()
        digits.authenticate(with: nil, configuration: configuredDigits(with: numberWithoutZero)) { [unowned self] session, error in
            
            guard error == nil else{
                return
            }
            DispatchQueue.main.async {
               
                self.conView.alpha = 1
                UIApplication.shared.statusBarStyle = .lightContent
                UserDefaults.standard.set(number, forKey: "phoneNumber")
                self.isUserRegistered = true
            }
        }
        sender.isEnabled = true
        sender.setTitle("Отправить", for: .normal)
        self.activityIndicator.stopAnimating()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapToScrollView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.init(netHex: Colors.yellow)
        Notifications.shared.setKeyboardObservers(inScrollView: scrollView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Notifications.shared.removeKeyboardObservers(inScrollView: scrollView)
    }
}
//MARK: Helper functions

extension LoginViewController{
    func configuredDigits(with number: String) -> DGTAuthenticationConfiguration {
        let configuration = DGTAuthenticationConfiguration(accountFields: .defaultOptionMask)
        configuration!.phoneNumber = "+996" + number
        configuration!.appearance = DGTAppearance()
        configuration!.title = "Пчелка"
        let digitsAppearance = configuration!.appearance
        digitsAppearance!.backgroundColor = UIColor.init(netHex: Colors.yellow)
        digitsAppearance!.accentColor = UIColor.init(netHex: Colors.black)
        digitsAppearance!.headerFont = UIFont(name: ".SFUIText", size: 18)
        digitsAppearance!.labelFont = UIFont(name: ".SFUIText", size: 16)
        digitsAppearance!.bodyFont = UIFont(name: ".SFUIText", size: 16)
        
        return configuration!
    }
    func addTapToScrollView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewApplicationViewController.dismissKeyboard))
        
        scrollView.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        scrollView.endEditing(true)
    }
    
}
extension LoginViewController{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "0"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

