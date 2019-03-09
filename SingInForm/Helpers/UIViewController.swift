//
//  UIViewController.swift
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

extension UIViewController {
    public func post(_ message: Notification.Name, userInfo: [AnyHashable : Any]? = nil, object: Any? = nil,
                     to notificationCenter: NotificationCenter = NotificationCenter.default) {
        notificationCenter.post(name: message, object: object, userInfo: userInfo)
    }
    
    public func alert(title: String = "", message: String, buttons: [String?], actions: [((UIAlertAction) -> Void)?],
                      animated: Bool = true, completion: (() -> Void)? = nil) {
        guard buttons.count == actions.count else { return }
        let alertView = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        for i in 0...buttons.count - 1 {
            if let button = buttons[i] {
                let style = i == buttons.count - 1 ? UIAlertAction.Style.cancel : .default
                alertView.addAction(UIAlertAction(title: button, style: style, handler: actions[i]))
            }
        }
        
        self.present(alertView, animated: animated, completion: completion)
    }
}

