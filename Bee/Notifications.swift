//
//  Keyboard.swift
//  Bee
//
//  Created by Ulan on 2/22/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import Foundation
import UIKit

class Notifications {
    static let shared = Notifications()
    
    private var scrollView: UIScrollView?
    
    func setKeyboardObservers(inScrollView scrollView:UIScrollView) {
        self.scrollView = scrollView
        let notifCenter = NotificationCenter.default
        notifCenter.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notifCenter.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeKeyboardObservers(inScrollView scrollView: UIScrollView) {
        self.scrollView = nil
        let notifCenter = NotificationCenter.default
        notifCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notifCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide , object: nil)
    }
    
    @objc private func keyboardWillShow(_ notif: Notification) {
        let keyboardFrameValue = notif.userInfo![UIKeyboardFrameBeginUserInfoKey]
        let keyboardFrame = (keyboardFrameValue! as AnyObject).cgRectValue
        var scrollViewInsets = self.scrollView!.contentInset
        scrollViewInsets.bottom = (keyboardFrame?.size.height)!
        let modelName = UIDevice.current.modelName
        var desiredOffset = CGPoint()
        if modelName == Devices.iPhone5 || modelName == Devices.iPhone5s || modelName == Devices.iPhoneSE{
            desiredOffset = CGPoint(x: 0, y: scrollViewInsets.bottom/2.5)
        } else if modelName == Devices.iPhone6Plus || modelName == Devices.iPhone7Plus || modelName == Devices.iPhone6sPlus {
            desiredOffset = CGPoint(x: 0, y: scrollViewInsets.bottom/8)
        }
        else{
            desiredOffset = CGPoint(x: 0, y: scrollViewInsets.bottom/5)
        }
        self.scrollView!.setContentOffset(desiredOffset, animated: true)
    }
    
    @objc private func keyboardWillHide(_ notif: Notification) {
        var scrollViewInsets = self.scrollView!.contentInset
        scrollViewInsets.bottom = 0;
        let desiredOffset = CGPoint(x: 0, y: 0)
        self.scrollView!.setContentOffset(desiredOffset, animated: true)
    }
    
}
