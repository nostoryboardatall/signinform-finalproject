//
//  SignInController+Handlers.swift
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

extension SignInController {
    // handler for sign in button
    @objc func signInAction() {
        // first we check for all data to be correct
        if validate() {
            //print("signIn with values: email: \(emailTextField.text ?? ""), password: \(passwordTextField.text ?? "")")
        }
    }
    
    // handler for sign up button
    @objc func signUpAction() {
        // show the sign up controller
        let signUpViewController = SignUpController()
        navigationController?.pushViewController(signUpViewController, animated: true)
    }
    
    @objc func didFinishSignUp(_ notification: Notification) {
        // check if message parameter is not nil
        if let userInfo = notification.userInfo as? [String: AnyHashable] {
            // now check if it is a User class
            if let user = userInfo["User"] as? User {
                // fill the form
                emailTextField.text = user.email
                passwordTextField.text = user.password
                
               // print("signUp with values: profileName: \(user.profileName ?? ""), email: \(user.email ?? ""), password: \(user.password ?? "")")
                
                // do sign in
                signInAction()
            }
        }
    }
}
