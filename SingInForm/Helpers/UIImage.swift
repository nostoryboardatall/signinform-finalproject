//
//  UIImage.swift
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

extension UIImage {
    // Deprecated
    func imageWithTintColor(_ color: UIColor?) -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0.0, y: size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(.normal)
        context?.clip(to: rect, mask: cgImage)
        
        color?.setFill()
        context?.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func tint(with color: UIColor) -> UIImage? {
        return self.imageWithTintColor(color)
    }
    
    func crop(to size: CGSize) -> UIImage? {
        guard let cgImage = cgImage else { return nil }
        
        let contextImage: UIImage = UIImage(cgImage: cgImage)
        // handle the device screen dimension!!!!
        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        var contextSize: CGSize = contextImage.size
        var origin = CGPoint.zero
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            origin.x = ((contextSize.width - scaledSize.width) * 0.5).rounded(.up)
            contextSize.width = scaledSize.width
        } else {
            origin.y = ((contextSize.height - scaledSize.height) * 0.5).rounded(.up)
            contextSize.height = scaledSize.height
        }
        
        // Create bitmap image from context using the rect
        let rect = CGRect(origin: origin, size: contextSize)
        let imageRef: CGImage = cgImage.cropping(to: rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(cgImage: imageRef, scale: scale, orientation: imageOrientation)
        return image
    }
    
    func thumb(to thumbSize: CGSize) -> UIImage? {
        // 1. resize to smaller side of the original image
        let newSize = CGSize(from: size, with: size.ratio(to: thumbSize)).rounded(.up)
        
        UIGraphicsBeginImageContextWithOptions(newSize, true, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: newSize))
        // 2. crop to thumb size from center of the thumb image
        let thumb = UIGraphicsGetImageFromCurrentImageContext()?.crop(to: thumbSize)
        UIGraphicsEndImageContext()
        
        return thumb
    }
    
    class func crop(_ image: UIImage?, to size: CGSize) -> UIImage? {
        return image?.crop(to: size)
    }
    
    class func thumb(_ image: UIImage?, to size: CGSize) -> UIImage? {
        return image?.thumb(to: size)
    }
    
    class func fill(_ sequence: [UIImage?]) -> UIImage? {
        if sequence.count > 0 {
            if let firstImage =  sequence[0] {
                let size = CGSize(width: firstImage.size.width * CGFloat(sequence.count), height: firstImage.size.height)
                UIGraphicsBeginImageContextWithOptions(size, true, 1.0)
                for i in 0...sequence.count - 1 {
                    guard let image = sequence[i] else { return nil }
                    image.draw(in: CGRect(origin: CGPoint(x: image.size.width * CGFloat(i), y: 0.0),
                                          size: image.size))
                }
                let output: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return output
            }
        }
        
        return nil
    }
    
    class func fill(with image: UIImage?, count: Int) -> UIImage? {
        guard let image = image else { return nil }
        let pattern: [UIImage?] = Array(repeating: image, count: count)
        return UIImage.fill(pattern)
    }
}
