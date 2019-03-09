//
//  RCButton.swift
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

class RCButton: UIButton {
    /**
     
     */
    var isRoundedCorners: Bool = false {
        didSet {
            setNeedsLayout()
        }
    }

    /**
     
     */
    private var displacement: CGFloat {
        return isRoundedCorners ? 0.0 : 4.0
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = isRoundedCorners ? frame.height * 0.5 : 0.0
        layer.masksToBounds = isRoundedCorners

        contentHorizontalAlignment = .left
        imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 14.0, bottom: 0.0, right: 0.0)
        let availableSpace = bounds.inset(by: contentEdgeInsets)
        let availableWidth = availableSpace.width -
            (imageEdgeInsets.right + imageEdgeInsets.left) -
            (imageView?.frame.width ?? 0.0) - (titleLabel?.frame.width ?? 0.0)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: availableWidth * 0.5, bottom: 0.0, right: 0.0)
    }
}
