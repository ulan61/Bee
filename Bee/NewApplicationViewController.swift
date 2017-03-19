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
    
    @IBOutlet weak var descriptionTextView: UITextView!{
        didSet{
            descriptionTextView.delegate = self
            descriptionTextView.font = UIFont(name: ".SFUIDisplay", size: 16)
            descriptionTextView.textColor = UIColor(netHex: Colors.greyTextFieldText)
            descriptionTextView.text = "Опишите то, что необходимо сделать"
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
            addressTF.autocorrectionType = .no
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
    
    @IBOutlet weak var activityIndicator:UIActivityIndicatorView!{didSet{activityIndicator.hidesWhenStopped = true}}
    
    @IBAction func sendApplication(_ sender: UIButton) {
        //Check text in textAreas
        guard isAllFieldsFilled() else {
            AlertView.shared.show(in: self, withTitle: "Пустые поля", subtitle: "Пожалуйста, заполните все поля", buttonTitle: "ОК")
            return
        }
        //Check telephone number
        guard telephoneNumberTF.isRightTelephoneNumber() else {
            AlertView.shared.show(in: self, withTitle: "Неправильный номер", subtitle: "Пожалуйста, убедитесь в правильности набранного номера", buttonTitle: "ОК")
            return
        }
        //Check Internet
        guard Internet.isAvailable() else {
            AlertView.shared.show(in: self, withTitle: "Соединение отсутствует", subtitle: "Убедитесь, что вы подключены к интернету", buttonTitle: "OK")
            return
        }
        
        let parameters = ["description": descriptionTextView.text!,
                          "price": costTF.text!,
                          "address": addressTF.text!,
                          "number": telephoneNumberTF.text!.getDigits(),
                          "category": "Сантехнические услуги"]
        activityIndicator.startAnimating()
        sender.setTitle("", for: .normal)
        sender.isEnabled = false
        NewApplication.shared.post(parameters: parameters as NSDictionary){ [unowned self] response in
            switch response.result {
            case .success:
                sender.isEnabled = true
                self.activityIndicator.stopAnimating()
                sender.setTitle("Отправить", for: .normal)
                AlertView.shared.show(in: self, withTitle: "Заявка принята", subtitle: "Ваш заявка принята, ожидайте", buttonTitle: "OK")
                self.clearTextAreas()
                UserDefaults.standard.removeObject(forKey: "selectedEmployee")
                break
            case .failure(let error):
                sender.isEnabled = true
                self.activityIndicator.stopAnimating()
                sender.setTitle("Отправить", for: .normal)
                AlertView.shared.show(in: self, withTitle: "Ошибка", subtitle: "Ошибка на сервере", buttonTitle: "OK")
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapToScrollView()
    }
    
    //MARK: View life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Notifications.shared.setKeyboardObservers(inScrollView: scrollView)
        self.tabBarController?.navigationItem.title = "Новая заявка"
        self.view.backgroundColor = UIColor(netHex: Colors.greyBackground)
        guard let chosenEmployee = UserDefaults.standard.string(forKey: "selectedEmployee") else {
            chooseTF.text = ""
            return
        }
        chooseTF.text = chosenEmployee
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Notifications.shared.removeKeyboardObservers(inScrollView: scrollView)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        setBackItem()
        guard let searchVC = segue.destination as? SearchViewController else {
            return
        }
        searchVC.cost = costTF.text!
        searchVC.serviceDescription = descriptionTextView.text!
    }
    
}

//MARK: Helper functions

extension NewApplicationViewController{
    
    func addTapToScrollView() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewApplicationViewController.dismissKeyboard))
        
        scrollView.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        scrollView.endEditing(true)
    }
    
    func clearTextAreas() {
        addressTF.text = ""
        telephoneNumberTF.text = ""
        costTF.text = ""
        descriptionTextView.text = "Опишите то, что необходимо сделать"
        descriptionTextView.textColor = UIColor.init(netHex: Colors.greyTextFieldText)
        chooseTF.text = ""
        UserDefaults.standard.removeObject(forKey: "selectedEmployee")
    }
    func setBackItem() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        tabBarController?.navigationItem.backBarButtonItem = backItem
    }
    
    func isAllFieldsFilled() -> Bool{
        if descriptionTextView.textColor != UIColor.init(netHex: Colors.greyTextFieldText) && !chooseTF.text!.isEmpty && !costTF.text!.isEmpty && !addressTF.text!.isEmpty && !telephoneNumberTF.text!.isEmpty {
            return true
        }
        return false
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
}

//MARK: UITextViewDelegate methods
extension NewApplicationViewController {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.init(netHex: Colors.greyTextFieldText) {
            textView.text = ""
            textView.textColor = .black
        }
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Опишите то, что необходимо сделать"
            textView.textColor = UIColor.init(netHex: Colors.greyTextFieldText)
        }
    }
}
