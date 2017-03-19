//
//  Extensions.swift
//  Bee
//
//  Created by Ulan on 1/31/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import Foundation
import UIKit
import FontAwesome_swift


//MARK: TabBarController
extension UITabBarController{
    func setTabbarController() -> UITabBarController
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let tabbarController = storyboard.instantiateViewController(withIdentifier: "tabBar") as! UITabBarController
        
        
        let tabbar = tabbarController.tabBar
        let newApplication = tabbar.items![0]
        newApplication.title = "Новая заявка"
        newApplication.image = UIImage.fontAwesomeIcon(name: .plus, textColor: .black,
                                                       size: .init(width: 30, height: 30))
        
        let myApplication = tabbar.items![1]
        myApplication.title = "Мои заявки"
        myApplication.image = UIImage.fontAwesomeIcon(name: .history, textColor: .black,
                                                      size: .init(width: 30, height: 30))
        
        let myProfile = tabbar.items![2]
        myProfile.title = "Мой профиль"
        myProfile.image = UIImage.fontAwesomeIcon(name: .user, textColor: .black,
                                                  size: .init(width: 30, height: 30))

        return tabbarController
    }
}

//MARK: String
extension String{
    func getDigits() -> String {
        let component = self.components(separatedBy: NSCharacterSet.decimalDigits.inverted)
        let list = component.filter({ $0 != "" })
        var numberStr = ""
        for string in list {
            numberStr.append(string)
        }
        return numberStr
    }
    
    func stringByAddingPercentEncodingForURLQueryParameter() -> String {
        let allowedCharacters = NSCharacterSet.urlQueryAllowed
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters)!
    }
}


//MARK: UIButton
extension UIButton {
    func setTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: titleLabel!.text!)
        if titleLabel?.textAlignment == .center || titleLabel?.textAlignment == .right {
            attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: attributedString.length-1))
        } else {
            attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        }
        titleLabel?.attributedText = attributedString
    }
}

//MARK:UIColor
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}
//MARK: UILabel
extension UILabel{
    func configure(borderColor: UIColor, iconColor: UIColor, icon: String) {
        
        self.layer.borderWidth = 1
        self.layer.borderColor = borderColor.cgColor
        self.textColor = iconColor
        self.font = UIFont.fontAwesome(ofSize: 18)
        self.text = icon
        self.textAlignment = .center
    }
}
//MARK: UITextField
extension UITextField{
    
    func isRightTelephoneNumber() -> Bool{
        let str = self.text!
        var compareStr = ""
        
        if str != "" && str.characters.count == 16 {
            let startIndex = str.startIndex
            let endIndex = str.index(str.startIndex, offsetBy: 4)
            compareStr = str[startIndex...endIndex]
            if compareStr == "0 (77" || compareStr == "0 (70" || compareStr == "0 (55" {
                return true
            }
            else{
                return false
            }
        }
        else{
            return false
        }
    }
    func configure(withIcon icon: String,
                   iconColor: UIColor,
                   text: String,
                   textColor: UIColor,
                   placeholderTextColor:UIColor,
                   backgroundColor: UIColor,
                   borderColor:UIColor,
                   isLeftView: Bool) {
        self.clearsOnBeginEditing = true
        self.font = UIFont(name: ".SFUIDisplay", size: 16)
        self.layer.borderWidth = 1.0
        self.layer.borderColor = borderColor.cgColor
        self.backgroundColor = backgroundColor
        self.attributedPlaceholder = NSAttributedString(string: text,
                                                    attributes: [NSForegroundColorAttributeName: placeholderTextColor])
        self.textColor = textColor
        var labelView: UILabel!
        
        if isLeftView{
            labelView = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.height, height: self.bounds.height))
        }
        else{
            labelView = UILabel(frame: CGRect(x: 10, y: 0, width: self.bounds.height, height: self.bounds.height))
        }
        labelView.configure(borderColor: borderColor, iconColor: iconColor, icon: icon)
        
        let view = UIView(frame: CGRect(x: 0,
                                        y: 0,
                                        width: self.bounds.height + 10,
                                        height: self.bounds.height))
        
        view.addSubview(labelView)
        
        if isLeftView {
            self.leftView = view
            self.leftViewMode = UITextFieldViewMode.always
        }
        else{
            let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.bounds.height))
            self.leftView = leftView
            self.leftViewMode = UITextFieldViewMode.always
            self.rightView = view // space in beginning
            self.rightViewMode = UITextFieldViewMode.always
        }
    }
}
//MARK: UIScrollView
extension UIScrollView {
    var isAtTop: Bool {
        return contentOffset.y <= verticalOffsetForTop
    }
    
    var isAtBottom: Bool {
        return contentOffset.y >= verticalOffsetForBottom
    }
    
    var verticalOffsetForTop: CGFloat {
        let topInset = contentInset.top
        return -topInset
    }
    
    var verticalOffsetForBottom: CGFloat {
        let scrollViewHeight = bounds.height
        let scrollContentSizeHeight = contentSize.height
        let bottomInset = contentInset.bottom
        let scrollViewBottomOffset = scrollContentSizeHeight + bottomInset - scrollViewHeight
        return scrollViewBottomOffset
    }
}
//MARK: UIDevice
extension UIDevice {
    
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        
        switch identifier {
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
        case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
        case "iPhone8,4":                               return "iPhone SE"
        default:                                        return identifier
        }
    }
}
