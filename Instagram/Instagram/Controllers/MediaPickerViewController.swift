//
//  MediaPickerViewController.swift
//  Instagram
//
//  Created by PJ Martinez on 2/26/18.
//  Copyright © 2018 Paolo Martinez. All rights reserved.
//

import UIKit

class MediaPickerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var photo: UIImage!
    var editedPhoto: UIImage!
    
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func presentVC() {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func onUploadButtonPressed(_ sender: Any) {
        presentVC()
    }

    @IBAction func onShareButtonPressed(_ sender: Any) {
        Post.postUserImage(image: editedPhoto, withCaption: captionTextField.text) { (success, error) -> Void in
            if success {
                print("Successful post")
                self.dismiss(animated: true, completion: nil)
            }
            else {
                print("Problem saving post")
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        // Do something with the images (based on your use case)
        if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            postImageView.image = originalImage
            photo = originalImage
        }
        
        editedPhoto = resize(image: photo, newSize: CGSize(width: 300, height:300))
        
        // Dismiss UIImagePickerController to go back to your original view controller
        self.dismiss(animated: true, completion: nil)
    }
    
    // Resize image to store to db
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRect(x:0, y:0, width: newSize.width, height: newSize.height))
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
}
