//
//  ViewController.swift
//  Bee
//
//  Created by Ulan on 1/30/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import UIKit
import SwiftMaskTextfield

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var conView: UIView! { didSet{ conView.alpha = 0 } }
    
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
    
    @IBAction func send(_ sender: UIButton) {
        let str = textField.text!
        var compareStr = ""
        
        if str != "" && str.characters.count == 16 {
            let startIndex = str.startIndex
            let endIndex = str.index(str.startIndex, offsetBy: 4)
            compareStr = str[startIndex...endIndex]
            if compareStr == "0 (77" || compareStr == "0 (70" || compareStr == "0 (55" {
                //TODO: post data to server
                
                print(str.getDigits())
                
                //TODO: show another view controller
                conView.alpha = 1
                textField.resignFirstResponder()
                
                print("Номер правильный")
            }
            else{
                //TODO: show alert
                print("Номер неправильный")
            }
        } else{
            print("Введите номер")
        }
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

extension LoginViewController{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "0"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

