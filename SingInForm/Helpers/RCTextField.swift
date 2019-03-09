//
//  RCTextField.swift
//
//  Created by Home on 2018.
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

class RCTextField: UITextField {
    /**
     
     */
    var caption: String = ""

    /**
     
     */
    var isRoundedCorners: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }
    
    /**
     
     */
    var leftImage: UIImage? {
        didSet {
            self.leftView = UIImageView(image: leftImage)
            self.leftViewMode = .always
        }
    }

    /**
     
     */
    private var displacement: CGFloat {
        return leftImage == nil ? 0.0 : 4.0
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = isRoundedCorners ? frame.height * 0.5 : 0.0
        layer.masksToBounds = isRoundedCorners
        
        super.layoutSubviews()
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var leftViewRect = super.leftViewRect(forBounds: bounds)
        leftViewRect.origin.x += displacement
        return leftViewRect
    }
    
    public func emailIsInvalid() -> Bool {
        guard let _ = text else { return false }
        
        let format = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format:"SELF MATCHES %@", format)
        
        return !predicate.evaluate(with: text!)
    }
    
    public func isEmpty() -> Bool {
        guard let _ = text else { return false }
        return text!.isEmpty
    }
}
