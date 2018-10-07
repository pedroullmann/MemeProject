//
//  ViewController.swift
//  MemeProject
//
//  Created by Pedro Ullmann on 10/6/18.
//  Copyright © 2018 Pedro Ullmann. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {

    // MARK: Variables
    private let imagePickerController = UIImagePickerController()
    private var memedImage = UIImage()
    
    // MARK: Outlets
    @IBOutlet weak var imagePicker: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavbar(isEnable: false)
        configButtons()
        configDelegates()
        configTextFields()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: Functions
    private func configNavbar(isEnable: Bool) {
        let navItem = UINavigationItem(title: "MemeApp");
        let actionItem = UIBarButtonItem(barButtonSystemItem: .action,
                                         target: self,
                                         action: #selector(actionTapped))
        let cancelItem = UIBarButtonItem(title: "Cancel",
                                         style: .plain,
                                         target: self,
                                         action: #selector(cancelTapped))

        navItem.rightBarButtonItem = cancelItem
        navItem.leftBarButtonItem = actionItem
        actionItem.isEnabled = isEnable
        
        navigationBar.setItems([navItem], animated: false)
    }
    
    @objc func actionTapped() {
        let memedImage = save()
        let imageToShare = [memedImage.memedImage]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func cancelTapped() {
        configTextFields()
        configNavbar(isEnable: false)
        imagePicker.image = UIImage()
    }
    
    private func hidingElements(isHidden: Bool) {
        navigationBar.isHidden = isHidden
        toolBar.isHidden = isHidden
    }
    
    private func configButtons() {
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    private func configDelegates() {
        imagePickerController.delegate = self
        topTextField.delegate = self
        bottomTextField.delegate = self
    }
    
    private func configTextFields() {
        let memeTextAttributes:[String:Any] = [
            NSAttributedStringKey.strokeColor.rawValue: UIColor.white,
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeWidth.rawValue: 3.0]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
        
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
    }
    
    // MARK: NotificationCenter
    private func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0.0
    }
    
    private func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(_:)),
                                               name: .UIKeyboardWillShow,
                                               object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                                               name: .UIKeyboardWillHide,
                                               object: nil)
    }
    
    private func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIKeyboardWillShow,
                                                  object: nil)
        NotificationCenter.default.removeObserver(self,
                                                  name: .UIKeyboardWillHide,
                                                  object: nil)
    }
    
    // MARK: Camera and Album
    @IBAction func pickAnImageFromCamera(_ sender: Any) {
        imagePickerController.sourceType = .camera
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromAlbum(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // MARK: Generate MemedImage and Save
    private func generateMemedImage() -> UIImage {
        
        hidingElements(isHidden: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hidingElements(isHidden: false)
        
        return memedImage
    }
    
    private func save() -> Meme {
        memedImage = generateMemedImage()
        
        let meme = Meme(topText: topTextField.text!,
                        bottomText: bottomTextField.text!,
                        originalImage: imagePicker.image!,
                        memedImage: memedImage)
        return meme
    }
}

// MARK: UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePicker.contentMode = .scaleAspectFit
            imagePicker.image = pickedImage
            configNavbar(isEnable: true)
        }
        
        dismiss(animated: true, completion: nil)
    }
}

// MARK: TextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
