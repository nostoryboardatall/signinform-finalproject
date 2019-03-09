//
//  SignUpController+TextField.swift
//
//  Created by Home on 2019.
//  Copyright 2017-2018 NoStoryboardsAtAll Inc. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to
//  deal in the Software without restriction, including without limitation the
//  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
//  sell copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
//  OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
//  IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

import UIKit

extension SignUpController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // remove keyboard
        textField.resignFirstResponder()
        
        // same as sign in controller, toggle the focus for text fields or do sign up
        switch textField {
        case profileNameTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            doneAction()
        default:
            break
        }
        
        return true
    }
    
    @objc func willShowKeyboard(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            if inputContainer.frame.intersects(keyboardFrame.cgRectValue) {
                let deltaY = -(inputContainer.frame.intersection(keyboardFrame.cgRectValue).height + 8.0)
                
                inputContainerCenterYConstraints?.isActive = false
                
                inputContainerCenterYConstraints =
                    inputContainer.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor,
                                                            constant: deltaY)
                inputContainerCenterYConstraints?.isActive = true
                
                UIView.animate(withDuration: 0.69, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,
                               options: .curveEaseInOut, animations: {
                                self.view.layoutIfNeeded()
                }, completion: nil)
            }
        }
    }
    
    @objc func willHideKeyboard(_ notification: Notification) {
        inputContainerCenterYConstraints?.isActive = false
        inputContainerCenterYConstraints =
            inputContainer.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor)
        inputContainerCenterYConstraints?.isActive = true
        
        UIView.animate(withDuration: 0.69, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0,
                       options: .curveEaseInOut, animations: {
                        self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

