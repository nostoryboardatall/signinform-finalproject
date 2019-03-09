//
//  UISize.swift
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

extension CGSize {
    init(from size: CGSize, with ratio: CGFloat){
        self = CGSize(width: size.width * ratio, height: size.height * ratio)
    }
    
    func ratio(to size: CGSize, fitToSmall: Bool = true) -> CGFloat {
        var ratio: CGFloat = 1.0
        if fitToSmall {
            ratio = self.width <= self.height ? size.width / self.width : size.height / self.height
        } else {
            ratio = self.width > self.height ? size.width / self.width : size.height / self.height
        }
        return ratio
    }
    
    func rounded(_ rule: FloatingPointRoundingRule) -> CGSize {
        var size = CGSize.zero
        size.width = self.width.rounded(rule)
        size.height = self.height.rounded(rule)
        return size
    }
    
    static func *(left: CGSize, right: CGFloat) -> CGSize {
        return CGSize(from: left, with: right)
    }
}

extension CGSize: Hashable {
    public var hashValue: Int {
        return Int(self.width) * Int(self.height)
    }
}

