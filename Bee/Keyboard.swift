//
//  Keyboard.swift
//  Bee
//
//  Created by Ulan on 2/22/17.
//  Copyright © 2017 Sunrise. All rights reserved.
//

import Foundation
import UIKit

class Keyboard {
    static let shared = Keyboard()
    
    private var scrollView: UIScrollView?
    
    func setObservers(inScrollView scrollView:UIScrollView){
        self.scrollView = scrollView
        let notifCenter = NotificationCenter.default
        notifCenter.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notifCenter.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeObservers(inScrollView scrollView: UIScrollView) {
        self.scrollView = nil
        let notifCenter = NotificationCenter.default
        notifCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        notifCenter.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide , object: nil)
    }
    
    @objc private func keyboardWillShow(_ notif: Notification){
        let keyboardFrameValue = notif.userInfo![UIKeyboardFrameBeginUserInfoKey]
        let keyboardFrame = (keyboardFrameValue! as AnyObject).cgRectValue
        var scrollViewInsets = self.scrollView!.contentInset
        scrollViewInsets.bottom = (keyboardFrame?.size.height)!
        let desiredOffset = CGPoint(x: 0, y: scrollViewInsets.bottom/4)
        self.scrollView!.contentOffset = desiredOffset
    }
    
    @objc private func keyboardWillHide(_ notif: Notification) {
        var scrollViewInsets = self.scrollView!.contentInset
        scrollViewInsets.bottom = 0;
        let desiredOffset = CGPoint(x: 0, y: 0)
        self.scrollView!.setContentOffset(desiredOffset, animated: true)
    }
    
}
