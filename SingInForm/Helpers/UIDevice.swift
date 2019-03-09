//
//  UIDevice.swift
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

public let iPhone5ScreenSizes: CGSize = CGSize(width: 640.0, height: 1136.0)
public let iPhoneScreenSizes: Set<CGSize> = [
    CGSize(width: 640.0, height: 1136.0), CGSize(width: 750.0, height: 1334.0), CGSize(width: 1242.0, height: 2208.0)
]
public let iPhoneXScreenSizes: Set<CGSize> = [
    CGSize(width: 1125.0, height: 2436.0)
]
public let iPhoneXRScreenSizes: Set<CGSize> = [
    CGSize(width: 1242.0, height: 2688.0), CGSize(width: 828.0, height: 1792.0)
]

public enum DeviceFamily: Int {
    case unrecognized
    case iphone58
    case iphonex
    case iphonexr
}

public enum Model: Int {
    case notSupported
    case iphone
    case ipad
    case appletv
    case applewatch
    case simulator
    
    public var family: DeviceFamily {
        switch self {
        case .iphone, .simulator:
            let screen =
                CGSize(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height),
                       height: max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) * UIScreen.main.scale
            if iPhoneScreenSizes.contains(screen) {
                return .iphone58
            } else if iPhoneXScreenSizes.contains(screen) {
                return .iphonex
            } else if iPhoneXRScreenSizes.contains(screen) {
                return .iphonexr
            }
        default:
            break
        }
        return .unrecognized
    }
    
    public var isIphone5: Bool {
        let screen =
            CGSize(width: min(UIScreen.main.bounds.width, UIScreen.main.bounds.height),
                   height: max(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) * UIScreen.main.scale
        return screen == iPhone5ScreenSizes
    }
}

public extension UIDevice {
    
    /// Return raw device version code string or empty string if any problem appears.
    public var versionCode: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        if  let info = NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN),
                                encoding: String.Encoding.ascii.rawValue),
            let code = String(validatingUTF8: info.utf8String!) {
            return code
        }
        
        return ""
    }
}
