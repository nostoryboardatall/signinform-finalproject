//
//  SignInController.swift
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

class SignInController: UIViewController {
    // declaring form vaiables...
    
    // stack view for text fields
    lazy var inputContainer: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8.0
        
        return stack
    }()
    
    // stack view for buttons
    lazy var buttonsContainer: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .equalSpacing
        stack.spacing = 8.0
        
        return stack
    }()
    
    // sign in button
    lazy var signinButton: RCButton = {
        let button = RCButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isRoundedCorners = true
        button.setTitle("login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.backgroundColor = .blueButton
        button.setImage(UIImage(named: "enter"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        
        return button
    }()
    
    // sign up button
    lazy var signupButton: RCButton = {
        let button = RCButton(type: .system)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isRoundedCorners = true
        button.setTitle("sign up", for: .normal)
        button.setTitleColor(.blueButton, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
        button.backgroundColor = .white
        button.layer.borderColor = UIColor.blueButton.cgColor
        button.layer.borderWidth = 1.5
        button.setImage(UIImage(named: "singup"), for: .normal)
        button.tintColor = .blueButton
        button.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        
        return button
    }()
    
    // email input
    lazy var emailTextField: RCTextField = {
        let textField = RCTextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = true
        textField.layoutMargins = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0)
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.textFieldBorder.cgColor
        textField.layer.borderWidth = 1.0
        textField.font = UIFont.systemFont(ofSize: 17.0)
        textField.placeholder = "email"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.leftImage = AppConstants.Appearance.Images.email?.tint(with: .textFieldBorder)
        textField.isRoundedCorners = true
        textField.delegate = self
        
        return textField
    }()
    
    // password input
    lazy var passwordTextField: RCTextField = {
        let textField = RCTextField()
        
        textField.translatesAutoresizingMaskIntoConstraints = true
        textField.caption = "password"
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.textFieldBorder.cgColor
        textField.layer.borderWidth = 1.0
        textField.font = UIFont.systemFont(ofSize: 17.0)
        textField.placeholder = "password"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.keyboardType = .default
        textField.isSecureTextEntry = true
        textField.returnKeyType = .go
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.leftImage = AppConstants.Appearance.Images.password?.tint(with: .textFieldBorder)
        textField.isRoundedCorners = true
        textField.delegate = self
        
        return textField
    }()
    
    // calculate height for buttons and text fields.
    // if current devise is iPhone5 return 38.0 pixels, else return 48.0
    var controlsHeight: CGFloat {
        let model: Model = (UIDevice.current.userInterfaceIdiom == .phone) ? .iphone : .notSupported
        return model.isIphone5 ? 38.0 : 48.0
    }

    // Do any additional setup here
    override func viewDidLoad() {
        super.viewDidLoad()
        addObservers()
        setupView()
    }
    
    // Setup your view and constraints here
    override func loadView() {
        super.loadView()
        prepareView()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // remove keyboard when tapping anywhere in view controller
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
    private func addObservers() {
        // add an observer for notification .didFinishSignUp
        NotificationCenter.default.addObserver(self, selector: #selector(didFinishSignUp),
                                               name: .signupAndLogin, object: nil)
    }
    
    private func setupView() {
        // remove navigation bar for that view controller
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .background
    }
    
    private func prepareView() {
        // fill the stack views
        buttonsContainer.addArrangedSubview(signinButton)
        buttonsContainer.addArrangedSubview(signupButton)
        
        inputContainer.addArrangedSubview(emailTextField)
        inputContainer.addArrangedSubview(passwordTextField)
        
        // add stack views to view controller
        view.addSubview(inputContainer)
        view.addSubview(buttonsContainer)

        // activate constraints
        NSLayoutConstraint.activate([
            inputContainer.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            inputContainer.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            inputContainer.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            
            emailTextField.heightAnchor.constraint(equalToConstant: controlsHeight),
            passwordTextField.heightAnchor.constraint(equalToConstant: controlsHeight),
            
            buttonsContainer.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            buttonsContainer.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            buttonsContainer.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            
            signinButton.heightAnchor.constraint(equalToConstant: controlsHeight),
            signupButton.heightAnchor.constraint(equalToConstant: controlsHeight)
        ])
    }

    // simple validation
    func validate() -> Bool {
        if emailTextField.emailIsInvalid() {
            alert(message: "Email is invalid", buttons: ["OK"], actions: [nil])
            return false
        }
        
        if passwordTextField.isEmpty() {
            alert(message: "Password is not set", buttons: ["OK"], actions: [nil])
            return false
        }
        
        return true
    }
}

