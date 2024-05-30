//
//  RegisterPage.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 28.05.2024.
//

import UIKit

class RegisterPage: UIViewController {
    

    
    var imageViewm = UIImageView()
    var textField1 = UITextField()
    var textField2 = UITextField()
    var textField3 = UITextField()
    var butonNext = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleForRegisterPage()
        setUpUIs()
        gestureFonk()

    }
    
    private func titleForRegisterPage() {
        
        self.navigationItem.title  = "Register Page"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font : UIFont(name: "Papyrus", size: 25)!,
                                                                        NSAttributedString.Key.foregroundColor : UIColor.systemGray]
    }
    
    func gestureFonk() {
        
        imageViewm.isUserInteractionEnabled  = true
        let gR2 = UITapGestureRecognizer(target: self, action: #selector(showImagePickerController))
        imageViewm.addGestureRecognizer(gR2)
    }
    
    
    private func setUpUIs() {
        
        let screenWidth = view.frame.size.width
        view.backgroundColor = .systemBackground
        
        imageViewm.frame = CGRect(x: 0, y: 100, width: screenWidth, height: 300)
        imageViewm.layer.borderWidth = 0.7
        imageViewm.clipsToBounds = true
//        imageViewm.translatesAutoresizingMaskIntoConstraints = false
        imageViewm.contentMode = .scaleAspectFill
        imageViewm.image = UIImage(named: "Bart")
        view.addSubview(imageViewm)
        
        
        textField1.frame = CGRect(x: 20, y: 450, width: screenWidth - 40, height: 40)
//        textField1.layer.borderWidth = 0.7
        textField1.placeholder = "Enter the name of Place"
        textField1.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(textField1)
        
        textField2.frame = CGRect(x: 20, y: 520, width: screenWidth - 40, height: 40)
//        textField1.layer.borderWidth = 0.7
        textField2.placeholder = "Enter the name of Place"
        textField2.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(textField2)
        
        textField3.frame = CGRect(x: 20, y: 590, width: screenWidth - 40, height: 40)
        textField3.placeholder = "Enter the name of Place"
        textField3.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(textField3)
        
        butonNext.frame = CGRect(x: (screenWidth - 60) / 2, y: 670, width: 60, height: 50)
        butonNext.setTitle("Save", for: UIControl.State.normal)
        butonNext.setTitleColor(UIColor.black, for: UIControl.State.normal)
        butonNext.addTarget(self, action: #selector(passToMapPage), for: UIControl.Event.touchUpInside)
        view.addSubview(butonNext)
        
    }
    
    @objc func pass() {
        self.navigationController?.pushViewController(MapPage(), animated: true)
    }
    
    @objc func passToMapPage() {
        
        if let nameX = textField1.text , let typex = textField2.text , let commentx = textField3.text {
            Singleton.sharedInstance.name = nameX
            Singleton.sharedInstance.type = typex
            Singleton.sharedInstance.comment = commentx
            Singleton.sharedInstance.imagem = imageViewm.image!
            self.navigationController?.pushViewController(MapPage(), animated: true)
        }
    }
}

extension RegisterPage : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @objc func showImagePickerController() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.allowsEditing = true
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            imageViewm.image = editedImage
        } else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageViewm.image = originalImage
        }
        dismiss(animated: true)
    }
    
}
