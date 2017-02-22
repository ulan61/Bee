//
//  RequestViewController.swift
//  Bee
//
//  Created by Ulan on 2/1/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import Foundation
import UIKit
import SwiftMaskTextfield

let servicesViewControllerStoryboardId = "Services"
let myAppLicationTVStoryboardId = "MyApplication"

class NewApplicationViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate,UITabBarDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!{didSet{scrollView.isScrollEnabled = false}}
    
    @IBOutlet weak var chooseTF:UITextField!{
        didSet{
            chooseTF.configure(withIcon: FontAwesome.services, iconColor: UIColor(netHex:Colors.greyLabelText),
                               text: "Выберите услугу", textColor: .black,
                               placeholderTextColor: UIColor(netHex: Colors.greyTextFieldText),
                               backgroundColor: .white, borderColor: UIColor(netHex: Colors.strokeColor),
                               isLeftView: false)
            chooseTF.delegate = self
            chooseTF.tag = 0
            chooseTF.isSelected = false
        }
    }
    
    @IBOutlet weak var descriptionText: UITextView!{
        didSet{
            descriptionText.delegate = self
            descriptionText.font = UIFont(name: ".SFUIDisplay", size: 16)
            descriptionText.textColor = UIColor(netHex: Colors.greyTextFieldText)
            descriptionText.text = "Опишите то, что необходимо сделать"
        }
    }
    
    @IBOutlet weak var costTF: UITextField!{
        didSet{
            costTF.configure(withIcon: FontAwesome.cost, iconColor:  .black, text: "Планируемый бюджет (cом)",
                             textColor: .black, placeholderTextColor: UIColor(netHex: Colors.greyTextFieldText),
                             backgroundColor: .white, borderColor: UIColor(netHex: Colors.strokeColor), isLeftView: true)
            costTF.delegate = self
            costTF.tag = 1
            costTF.keyboardType = .decimalPad
        }
    }
    @IBOutlet weak var addressTF: UITextField!{
        didSet{
            addressTF.configure(withIcon: FontAwesome.place, iconColor: .black, text: "Ваш адрес", textColor: .black,
                                placeholderTextColor: UIColor(netHex: Colors.greyTextFieldText), backgroundColor: .white, borderColor: UIColor(netHex: Colors.strokeColor), isLeftView: true)
            addressTF.delegate = self
            addressTF.tag = 2
        }
    }
    @IBOutlet weak var telephoneNumberTF: SwiftMaskTextField!{
        didSet{
            telephoneNumberTF.configure(withIcon: FontAwesome.phone, iconColor: .black, text: "Номер телефона",
                                        textColor: .black, placeholderTextColor: UIColor(netHex: Colors.greyTextFieldText), backgroundColor: .white, borderColor: UIColor(netHex: Colors.strokeColor), isLeftView: true)
            telephoneNumberTF.delegate = self
            telephoneNumberTF.tag = 3
            telephoneNumberTF.keyboardType = .decimalPad
            telephoneNumberTF.formatPattern = "# (###) ##-##-##"
            
        }
    }
    
    @IBAction func sendApplication(_ sender: UIButton) {
        self.performSegue(withIdentifier: myAppLicationTVStoryboardId, sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новая заявка"
        addTapToScrollView()
    }
    
    //MARK: View life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "Новая заявка"
        self.view.backgroundColor = UIColor(netHex: Colors.greyBackground)
        Keyboard.shared.setObservers(inScrollView: scrollView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Keyboard.shared.removeObservers(inScrollView: scrollView)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let backItem = UIBarButtonItem()
        backItem.title = ""
        tabBarController?.navigationItem.backBarButtonItem = backItem
    }
    
}

//MARK: Helper functions

extension NewApplicationViewController{
    
    func addTapToScrollView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        scrollView.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        scrollView.endEditing(true)
    }
}

//MARK: UITextFieldDelegate methods

extension NewApplicationViewController{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            self.view.endEditing(true)
            self.performSegue(withIdentifier: servicesViewControllerStoryboardId, sender: self)
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 0 {
            textField.resignFirstResponder()
            scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: false)
        }
        textField.textColor = .black
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 1 && !textField.text!.isEmpty{
            textField.text = textField.text! + " сом"
        }
    }
}

//MARK: UITextViewDelegate methods
extension NewApplicationViewController {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.init(netHex: Colors.greyTextFieldText) {
            textView.text = ""
            textView.textColor = .black
        }
        scrollView.setContentOffset(CGPoint(x: 0,y: 0), animated: false)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Опишите то, что необходимо сделать"
            textView.textColor = UIColor.init(netHex: Colors.greyTextFieldText)
        }
    }
}
