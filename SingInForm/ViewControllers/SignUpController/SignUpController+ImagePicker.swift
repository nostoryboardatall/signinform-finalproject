//
//  SignUpController+ImagePicker.swift
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
import Photos

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func editImageAction() {
        let alert = UIAlertController(title: "Select picture", message: "", preferredStyle: .actionSheet)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        self.imagePicker = imagePicker
        
        alert.addAction(UIAlertAction(title: "Take a photo", style: .default , handler:{ (UIAlertAction) in
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                self.alert(title: "Error", message: "Camera is not available on that device",
                           buttons: [nil, "Close"], actions: [nil, nil])
                return
            }
            
            AVCaptureDevice.requestAccess(for: .video, completionHandler: {(aithorizationStatus) in
                if aithorizationStatus {
                    self.imagePicker.sourceType = .camera
                    self.imagePicker.allowsEditing = true
                    self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera) ?? []
                    self.present(imagePicker, animated: true, completion: nil)
                } else {
                    self.alert(title: "Warning", message: "Please grant accsess to camera if you want to take a photo!",
                               buttons: ["Settings", "Close"], actions: [{(_ ) in
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }, nil])
                }
            })
        }))
        
        alert.addAction(UIAlertAction(title: "Choose a picture", style: .default, handler:{ (UIAlertAction) in
            guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
                self.alert(title: "Error", message: "Photo library is not available on that device",
                           buttons: [nil, "Close"], actions: [nil, nil])
                return
            }
            
            PHPhotoLibrary.requestAuthorization({(authorizationStatus) in
                if authorizationStatus ==  PHAuthorizationStatus.authorized {
                    self.imagePicker.sourceType = .savedPhotosAlbum
                    self.imagePicker.allowsEditing = true
                    self.imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) ?? []
                    self.present(imagePicker, animated: true, completion: nil)
                } else {
                    self.alert(title: "Warning",
                               message: "Please grant accsess to photo library if you want to add an user picture!",
                               buttons: ["Settings", "Close"], actions: [{(_ ) in
                                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                                }, nil])
                }
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var image: UIImage?
        if let edited = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = edited
        } else if let original = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = original
        }
        picker.dismiss(animated: true, completion: {
            if let cgImage = image?.cgImage {
                self.userImage.image = UIImage(cgImage: cgImage, scale: image!.scale, orientation: image!.imageOrientation)
            }
        })
    }
}
