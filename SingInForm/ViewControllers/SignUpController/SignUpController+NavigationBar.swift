//
//  SignUpController+NavigationBar.swift
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

extension SignUpController: UINavigationBarDelegate {
    // set the position of the navigation bar attached to the top
    public func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
    
    @objc public func cancelAction() {
        // hide sing up controller
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc public func doneAction() {
        // if form validate is successfull
        if validate() {
            // create User variable and fill it with form values
            let user = User()
            user.profileName = profileNameTextField.text
            user.email = emailTextField.text
            user.password = passwordTextField.text
            
            // create parameter for message
            var userInfo: [String:AnyHashable] = [:]
            // fill parametr with User variable
            userInfo.updateValue(user, forKey: "User")
            
            // post message to application
            navigationController?.popToRootViewController(animated: true)
            // hide sing up controller
            post(.signupAndLogin, userInfo: userInfo)
        }
    }
}
