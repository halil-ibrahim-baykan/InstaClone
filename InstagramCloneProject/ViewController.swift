//
//  ViewController.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 18/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let btnAddImage: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setImage(#imageLiteral(resourceName: "addImage"), for: UIControl.State.normal)
        
        //        btn.backgroundColor = .yellow
        btn.translatesAutoresizingMaskIntoConstraints = false // with this it accept the constraints for autolayout
        return btn
    }()

    let txtEmail: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Enter your email.."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        return txt
    }()
    
    let txtUserName: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Enter your username.."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        return txt
    }()
    let txtPassword: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.isSecureTextEntry = true
        txt.placeholder = "Enter your password.."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
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
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(btnAddImage)
        //        view.addSubview(txtEmail)
        
        //        btnAddImage.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        //        btnAddImage.center = view.center
        
        //we did it isActive because of we want to work the constraints which we'd given
        btnAddImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btnAddImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        btnAddImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnAddImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        
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
        
        let blueView = UIView()
        blueView.backgroundColor = .blue
        
        let stackView = UIStackView(arrangedSubviews: [txtEmail,txtUserName,txtPassword,btnSignup]) //,redView
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: btnAddImage.bottomAnchor, constant: 20),
//            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
//            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            
            stackView.heightAnchor.constraint(equalToConstant: 230)
            
      
        ])
        
        
         stackView.anchor(top: btnAddImage.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 20, paddingBottom: 0, paddingLeading: 45, paddingTrailing: -45),
     
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
                paddingTrailing:CGFloat){
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
   
        
    }
}

