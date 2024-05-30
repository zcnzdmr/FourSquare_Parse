//
//  ViewController.swift
//  FourSquareClone_Parse
//
//  Created by Özcan on 28.05.2024.
//

import UIKit
import Parse



class SignIn: UIViewController {
    
    var textField1 = UITextField()
    var textField2 = UITextField()
    var label1 = UILabel()
    var buton1 = UIButton()
    var buton2 = UIButton()
    var imagem = UIImageView()
    
    var repoObject = Repo()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUIs()
        repoObject.getData()

    }
    
    private func setUpUIs() {
        
        view.backgroundColor = .systemBackground
        
        let screenWidth = view.frame.size.width
        
        imagem.frame = view.bounds
        imagem.image = UIImage(named: "one")
        view.addSubview(imagem)
        
        label1.frame = CGRect(x: 10, y: 80, width: (screenWidth - 20), height: 65)
        label1.text = "FourSquare  Clone (Parse)"
        label1.font = UIFont(name: "Papyrus", size: 27)
        label1.textAlignment = .center
        label1.layer.cornerRadius = 10
        label1.layer.borderWidth = 0.6
        label1.clipsToBounds =  true
        label1.backgroundColor = UIColor.systemPink
        view.addSubview(label1)
        
        textField1.frame = CGRect(x: 25, y: 200, width: (screenWidth - 50), height: 40)
        textField1.borderStyle = UITextField.BorderStyle.roundedRect
        textField1.placeholder = "Enter your email"
        view.addSubview(textField1)
        
        textField2.frame = CGRect(x: 25, y: 270, width: (screenWidth - 50), height: 40)
        textField2.placeholder = "Enter your password"
        textField2.borderStyle = UITextField.BorderStyle.roundedRect
        view.addSubview(textField2)
        
        buton1.setTitle("Sign In", for: UIControl.State.normal)
        buton1.setTitleColor(.black, for: UIControl.State.normal)
        buton1.backgroundColor = UIColor.systemPink
        buton1.layer.cornerRadius = 10
        buton1.layer.borderWidth = 0.6
        buton1.clipsToBounds = true
        buton1.frame = CGRect(x: 30, y: 350, width: 80, height: 50)
        buton1.addTarget(self, action: #selector(singInFonk), for: UIControl.Event.touchUpInside)
        view.addSubview(buton1)
        
        buton2.setTitle("Sign Up", for: UIControl.State.normal)
        buton2.setTitleColor(.black, for: UIControl.State.normal)
        buton2.backgroundColor = UIColor.systemPink
        buton2.layer.cornerRadius = 10
        buton2.layer.borderWidth = 0.6
        buton2.clipsToBounds = true
        buton2.frame = CGRect(x: (screenWidth - 130), y: 350, width: 80, height: 50)
        view.addSubview(buton2)
        
        


    }
    
    @objc func singInFonk() {
        self.navigationController?.pushViewController(HomePage(), animated: true)
    }


}

