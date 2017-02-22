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
        setObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeObservers()
    }
}

//Helper functions 

extension LoginViewController{
    
    fileprivate func setObservers() {
        let modelName = UIDevice.current.modelName
        if modelName == Devices.iPhone5 || modelName == Devices.iPhone5s || modelName == Devices.iPhoneSE{
            let notifCenter = NotificationCenter.default
            notifCenter.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            notifCenter.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
    }
    
    fileprivate func removeObservers() {
        let modelName = UIDevice.current.modelName
        if modelName == Devices.iPhone5 || modelName == Devices.iPhone5s || modelName == Devices.iPhoneSE{
            let notifCenter = NotificationCenter.default
            notifCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            notifCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide , object: nil)
        }
    }
    
    func keyboardWillShow(_ notif: Notification){
        let keyboardFrameValue = notif.userInfo![UIKeyboardFrameEndUserInfoKey]
        let keyboardFrame = (keyboardFrameValue! as AnyObject).cgRectValue
        var scrollViewInsets = self.scrollView.contentInset
        scrollViewInsets.bottom = (keyboardFrame?.size.height)!
        let desiredOffset = CGPoint(x: 0, y: scrollViewInsets.bottom - 150)
        scrollView.setContentOffset(desiredOffset, animated: true)
    }
    
    func keyboardWillHide(_ notif: Notification) {
        var scrollViewInsets = self.scrollView.contentInset
        scrollViewInsets.bottom = 0;
        let desiredOffset = CGPoint(x: 0, y: 0)
        scrollView.setContentOffset(desiredOffset, animated: true)
    }
}

//MARK: UITextFieldDelagate methods 

extension LoginViewController{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = "0"
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
}

