//
//  SignUpController.swift
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

class SignUpController: UIViewController {
    // create a navigation bar variable
    lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        
        // also use autolayout
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        // set trabsparent background
        ////////////////////////////
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        navigationBar.delegate = self
        navigationBar.backgroundColor = .clear
        ////////////////////////////
        
        // set font
        ////////////////////////////
        navigationBar.tintColor = .blueButton
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blueButton]
        ////////////////////////////
        
        return navigationBar
    }()

    // left button for navigation bar
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(cancelAction), for: .touchUpInside)
        
        return button
    }()

    // inputs container
    lazy var inputContainer: UIStackView = {
        let stack = UIStackView()
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 8.0
        
        return stack
    }()
    
    // form variables:
    // 1. image view
    lazy var userImage: RCImageView = {
        let imageView = RCImageView(image: UIImage(named: "user_default"))
        
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .clear
        imageView.isRoundedCorners = true
        
        // create single tap gesture recognition for image view
        ////////////////////////////
        let gestureRecognition = UITapGestureRecognizer(target: self, action: #selector(editImageAction))
        imageView.addGestureRecognizer(gestureRecognition)
        imageView.isUserInteractionEnabled = true
        ////////////////////////////
        
        return imageView
    }()
    
    // 2. profile name text field
    lazy var profileNameTextField: RCTextField = {
        let textField = RCTextField()
        
        textField.caption = "name"
        textField.translatesAutoresizingMaskIntoConstraints = true
        textField.layoutMargins = UIEdgeInsets(top: 0.0, left: 20.0, bottom: 0.0, right: 0.0)
        textField.backgroundColor = .white
        textField.layer.borderColor = UIColor.textFieldBorder.cgColor
        textField.layer.borderWidth = 1.0
        textField.font = UIFont.systemFont(ofSize: 17.0)
        textField.placeholder = "name"
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .words
        textField.keyboardType = .alphabet
        textField.returnKeyType = .next
        textField.clearButtonMode = .whileEditing
        textField.contentVerticalAlignment = .center
        textField.leftImage = AppConstants.Appearance.Images.user?.tint(with: .textFieldBorder)
        textField.isRoundedCorners = true
        textField.delegate = self
        
        return textField
    }()
    
    // 3. email text field
    lazy var emailTextField: RCTextField = {
        let textField = RCTextField()
        
        textField.caption = "email"
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
    
    // 4. password text field
    lazy var passwordTextField: RCTextField = {
        let textField = RCTextField()
        
        textField.caption = "password"
        textField.translatesAutoresizingMaskIntoConstraints = true
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
    
    // calculated constraint to shift interface up when keyboard is shown
    var inputContainerCenterYConstraints: NSLayoutConstraint?
    
    // image picker for select user image
    weak var imagePicker: UIImagePickerController!

    // Do any additional setup here
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // remove keyboard when tapping anywhere in view controller
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }

    // Setup your view and constraints here
    override func loadView() {
        super.loadView()
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // subscribe for keyboard show/hide notification
        subscribeForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // unsubscribe from keyboard show/hide notification
        unsubscribeFromKeyboardNotification()
        super.viewWillDisappear(animated)
    }
    
    private func setupView() {
        view.backgroundColor = .background

        // setup the navigation bar item
        let standaloneItem = UINavigationItem()
        standaloneItem.title = "Sing Up"
        standaloneItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
        standaloneItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneAction))
        navigationBar.items = [standaloneItem]
    }
    
    private func prepareView() {
        // add navigation bar and main stack view to view controller
        view.addSubview(navigationBar)
        view.addSubview(inputContainer)
        
        // fill main stack view with form fields
        inputContainer.addArrangedSubview(userImage)
        inputContainer.addArrangedSubview(profileNameTextField)
        inputContainer.addArrangedSubview(emailTextField)
        inputContainer.addArrangedSubview(passwordTextField)
        
        // set the initial value for stack view's Y position
        inputContainerCenterYConstraints = inputContainer.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        
        // check that inputContainerCenterYConstraints is not nil
        guard let _ =  inputContainerCenterYConstraints else {
            print("Error defining vertical constraint")
            return
        }
        
        // activate the constraints
        NSLayoutConstraint.activate([
            navigationBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            navigationBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            navigationBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),

            inputContainer.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            inputContainerCenterYConstraints!,
            
            userImage.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.35),
            userImage.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.35),
            
            profileNameTextField.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            profileNameTextField.heightAnchor.constraint(equalToConstant: controlsHeight),

            emailTextField.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: controlsHeight),

            passwordTextField.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: controlsHeight)
        ])
   }
    
    private func subscribeForKeyboardNotification() {
        // add observer for keyboardWillShow notification
        NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        // add observer for keyboardWillHide notification
        NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func unsubscribeFromKeyboardNotification() {
        // remove observers for keyboardWillShow/keyboardWillHide notifications
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(UIResponder.keyboardWillHideNotification)
    }
    
    // validate method
    func validate() -> Bool {
        if profileNameTextField.isEmpty() {
            alert(message: "Profile name is not set", buttons: ["OK"], actions: [nil])
            return false
        }

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
