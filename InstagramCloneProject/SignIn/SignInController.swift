//
//  SignInController.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 22/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//
// dummy user: bera@gmail.com pas: berabaykan

import UIKit
import Firebase
import JGProgressHUD

class SignInController: UIViewController{
    let txtEmail: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Email address.."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.boldSystemFont(ofSize: 16)
        txt.addTarget(self, action: #selector(editingChanging), for: .editingChanged)
        return txt
    }()
    let txtPassword: UITextField = {
        let txt = UITextField()
        txt.placeholder = "Password.."
        txt.isSecureTextEntry = true
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.boldSystemFont(ofSize: 16)
        txt.addTarget(self, action: #selector(editingChanging), for: .editingChanged)
        return txt
    }()
    @objc fileprivate func editingChanging(){
        let checkFormCharacter =
            (txtEmail.text?.count ?? 0) > 0 &&
                (txtPassword.text?.count ?? 0) > 0 // I can add here contains '@' sign, but firebase alreadty do it.
        
        if checkFormCharacter {
            btnSignIn.backgroundColor = UIColor.ConvertRgb(red: 20, green: 155, blue: 205)//it's like regular blue
            btnSignIn.isEnabled = true
        }else{
            btnSignIn.backgroundColor = UIColor.ConvertRgb(red: 150, green: 205, blue: 245)// it's like light blue
            btnSignIn.isEnabled = false
        }
    }
    let btnSignIn : UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setTitle("Sign In", for: UIControl.State.normal)
        //        btn.backgroundColor = UIColor(red: 150/255, green: 205/255, blue: 245/255, alpha: 1)
        // crated an extention for UIColor
        btn.backgroundColor = UIColor.ConvertRgb(red: 150, green: 205, blue: 245)
        btn.layer.cornerRadius = 6
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(self, action: #selector(btnSignInClicked), for: UIControl.Event.touchUpInside)
        btn.isEnabled = false
        return btn
    }()
    @objc fileprivate func btnSignInClicked(){
        
        guard let email = txtEmail.text, let password = txtPassword.text else { return }
        
        let hud = JGProgressHUD(style: .light)
        hud.textLabel.text = "Signing in.."
        hud.show(in: self.view, animated: true)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("Error occurred when signing in.. \(error.localizedDescription)")
                hud.dismiss(animated: true)
                
                let unsuccessfulHud = JGProgressHUD(style: .light)
                unsuccessfulHud.textLabel.text = "Error occurred: \(error.localizedDescription)"
                unsuccessfulHud.show(in: self.view, animated: true)
                unsuccessfulHud.dismiss(afterDelay: 2)
                return
            }
            print("User signed in successfully.. userId: \(result?.user.uid)")
            hud.dismiss(animated: true)
            
            let successfulHud = JGProgressHUD(style: .light)
            successfulHud.textLabel.text = "Successful"
            successfulHud.show(in: self.view)
            successfulHud.dismiss(afterDelay: 1)
            
            let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
            
            guard let mainTabBarController = keyWindow?.rootViewController as? MainTabBarController else {return} // as a default => it's UIViewController. Also you can go SceneDelegate and can see there that ' self.window?.rootViewController = MainTabBarController() ' we did it before.
            
            mainTabBarController.showProfileView() // with that way we can reach the func inside of MainTabBarController..
            self.dismiss(animated: true, completion: nil) // with this, this view gonna close if it's not   we can't see the other views

            
        }
        
        
    }
    
    let logoView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.ConvertRgb(red: 0, green: 120,  blue: 175)
        let imgLogo = UIImageView(image: #imageLiteral(resourceName: "instagramLogo"))
        view.addSubview(imgLogo)
        imgLogo.anchor(top: nil, bottom: nil, leading: nil, trailing: nil, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 200, height: 50)
        imgLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imgLogo.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imgLogo.contentMode = .scaleAspectFill
        return view
    }()
    
    let btnGoSignUp: UIButton = {
        let btn = UIButton(type: .system)// should add (type: .system) without it it doesn't seem
        
        //        btn.setTitle("Don't you have an account yet? Sign Up.", for: .normal)
        let attrTitle = NSMutableAttributedString(string: "Don't you have an account yet?", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attrTitle.append(NSAttributedString(string: " Sign Up.", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.ConvertRgb(red: 20, green: 155, blue: 235)]))
        btn.setAttributedTitle(attrTitle, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn.addTarget(self, action: #selector(btnGoSignUpClicked), for: .touchUpInside)
        
        return btn
    }()
    
    @objc private func btnGoSignUpClicked(){
        let signUpController = SignUpController()
        navigationController?.pushViewController(signUpController, animated: true) // easiest way to change the view or like a segue
    }
    override var preferredStatusBarStyle: UIStatusBarStyle{ // we can make white the status items which are battery and clock items
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(btnGoSignUp)
        btnGoSignUp.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 50)
        view.addSubview(logoView)
        logoView.anchor(top:view.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 150)
        navigationController?.isNavigationBarHidden = true
        
        entryViewCreate()
    }
    
    fileprivate func entryViewCreate(){
        let stackView = UIStackView(arrangedSubviews: [txtEmail,txtPassword,btnSignIn])
        view.addSubview(stackView)
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.anchor(top: logoView.bottomAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 40, paddingBottom:0 , paddingLeading: 40, paddingTrailing: -40, width: 0, height: 185)
        
    }
    
}
