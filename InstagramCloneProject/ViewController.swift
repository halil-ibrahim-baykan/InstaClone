//
//  ViewController.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 18/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    let btnAddImage: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setImage(#imageLiteral(resourceName: "addImage"), for: UIControl.State.normal)
        
        //        btn.backgroundColor = .yellow
        btn.translatesAutoresizingMaskIntoConstraints = false // with this button accepts the constraints for autolayout
        return btn
    }()
    
    let txtEmail: UITextField = {
        let txt = UITextField()
        //        txt.translatesAutoresizingMaskIntoConstraints = false // we don't need this anymore because we added inside of the anchor func
        txt.placeholder = "Enter your email.."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.addTarget(self, action: #selector(valueChanging), for: .editingChanged)
        return txt
    }()
    
    @objc fileprivate func valueChanging(){
        let checkFormCharacter =
            (txtEmail.text?.count ?? 0) > 0 &&
            (txtUserName.text?.count ?? 0) > 0 &&
            (txtPassword.text?.count ?? 0) > 0
        
        if checkFormCharacter {
            btnSignup.backgroundColor = UIColor.ConvertRgb(red: 20, green: 155, blue: 205)
            btnSignup.isEnabled = true
        }else{
            btnSignup.backgroundColor = UIColor.ConvertRgb(red: 150, green: 205, blue: 245)
            btnSignup.isEnabled = false
        }
    }
    
    let txtUserName: UITextField = {
        let txt = UITextField()
        //        txt.translatesAutoresizingMaskIntoConstraints = false // it's the sam like above situation
        txt.placeholder = "Enter your username.."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.addTarget(self, action: #selector(valueChanging), for: .editingChanged)
        return txt
    }()
    let txtPassword: UITextField = {
        let txt = UITextField()
        //        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.isSecureTextEntry = true
        txt.placeholder = "Enter your password.."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.addTarget(self, action: #selector(valueChanging), for: .editingChanged)
        return txt
    }()
    let btnSignup : UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setTitle("Sign up", for: UIControl.State.normal)
        //        btn.backgroundColor = UIColor(red: 150/255, green: 205/255, blue: 245/255, alpha: 1)
        // crated an extention for UIColor
        btn.backgroundColor = UIColor.ConvertRgb(red: 150, green: 205, blue: 245)
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btnSignupClicked), for: UIControl.Event.touchUpInside)
        btn.isEnabled = false
        
        return btn
    }()
    
    @objc func btnSignupClicked(){
        
        guard let email = txtEmail.text else { return }
        guard let password = txtPassword.text else { return }
        guard let userName = txtUserName.text else { return }
        
        
        //        let email = "test@gmail.com"
        //        let userName = "user"
        //        let password =  "123456"
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("error \(error.localizedDescription)")
                return
            }
            
            print("user account created. id: \(result?.user.uid)")
            self.txtEmail.text = ""
            self.txtPassword.text = ""
            self.txtUserName.text = ""
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(btnAddImage)
        //        view.addSubview(txtEmail)
        
        //        btnAddImage.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        //        btnAddImage.center = view.center
        
        //we did it isActive because of we want to work the constraints which we'd given
        //        btnAddImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //        btnAddImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        btnAddImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        btnAddImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        // we said that safeAreaLayoutGuide-> it's gonna take safe area frame before it was superview frame
        btnAddImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 40, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 150, height: 150)
        
        //we can write it also with this way without writing isActive=true everytime
        //        NSLayoutConstraint.activate([
        //            txtEmail.topAnchor.constraint(equalTo: btnAddImage.bottomAnchor, constant: 20),
        //            txtEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
        //            txtEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
        //            txtEmail.heightAnchor.constraint(equalToConstant: 50)
        //        ])
        
        
        makeSignField()
        
    }
    
    fileprivate func makeSignField(){
        //        let redView = UIView()
        //        redView.backgroundColor = .red
        
        //        let blueView = UIView()
        //        blueView.backgroundColor = .blue
        
        let stackView = UIStackView(arrangedSubviews: [txtEmail,txtUserName,txtPassword,btnSignup]) //[redView,blueView]
        
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            //            stackView.topAnchor.constraint(equalTo: btnAddImage.bottomAnchor, constant: 20),
            //            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            //            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            
            //            stackView.heightAnchor.constraint(equalToConstant: 230)
            
            
        ])
        
        
        stackView.anchor(top: btnAddImage.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingLeading: 45, paddingTrailing: -45, width: 0, height: 230)
        
    }
    
    
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                bottom:NSLayoutYAxisAnchor?,
                leading:NSLayoutXAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingBottom: CGFloat,
                paddingLeading:CGFloat,
                paddingTrailing:CGFloat,
                width:CGFloat,
                height:CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom  = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        if let trailing = trailing{
            self.trailingAnchor.constraint(equalTo: trailing, constant: paddingTrailing).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
}

