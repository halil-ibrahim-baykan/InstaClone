//
//  SignUpController.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 18/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import UIKit
import Firebase
import JGProgressHUD

class SignUpController: UIViewController {
    
    let btnAddImage: UIButton = {
        let btn = UIButton(type: UIButton.ButtonType.system)
        btn.setImage(#imageLiteral(resourceName: "addImage"), for: UIControl.State.normal)
        //        btn.backgroundColor = .yellow // for testing button area
        btn.translatesAutoresizingMaskIntoConstraints = false // with this button accepts the constraints for autolayout
        btn.addTarget(self, action: #selector(btnAddImageClicked), for: UIControl.Event.touchUpInside)
        return btn
    }()
    @objc fileprivate func btnAddImageClicked(){ // it goes to the photos and we can pick an image
        let picker = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil) // it goes into photo library and with didFinishPickingMediaWithInfo method it goes away from view.
    }
    
    let txtEmail: UITextField = {
        let txt = UITextField()
        //        txt.translatesAutoresizingMaskIntoConstraints = false // we don't need this anymore because we added inside of the anchor func
        txt.placeholder = "Enter your email.."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.addTarget(self, action: #selector(editingChanging), for: .editingChanged)
        return txt
    }()
    let txtUserName: UITextField = {
        let txt = UITextField()
        //        txt.translatesAutoresizingMaskIntoConstraints = false // it's the same situation above
        txt.placeholder = "Enter your username.."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.addTarget(self, action: #selector(editingChanging), for: .editingChanged)
        return txt
    }()
    let txtPassword: UITextField = {
        let txt = UITextField()
        //        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.isSecureTextEntry = true // it makes the appereance of the text => secureText
        txt.placeholder = "Enter your password.."
        txt.backgroundColor = UIColor(white: 0, alpha: 0.05)
        txt.borderStyle = .roundedRect
        txt.font = UIFont.systemFont(ofSize: 16)
        txt.addTarget(self, action: #selector(editingChanging), for: .editingChanged)
        return txt
    }()
    @objc fileprivate func editingChanging(){
        let checkFormCharacter =
            (txtEmail.text?.count ?? 0) > 0 && // I can add here contains @ but firebase alreadty do it.
                (txtUserName.text?.count ?? 0) > 0 &&
                (txtPassword.text?.count ?? 0) > 0
        
        if checkFormCharacter {
            btnSignup.backgroundColor = UIColor.ConvertRgb(red: 20, green: 155, blue: 205)//it's like regular blue
            btnSignup.isEnabled = true
        }else{
            btnSignup.backgroundColor = UIColor.ConvertRgb(red: 150, green: 205, blue: 245)// it's like light blue
            btnSignup.isEnabled = false
        }
        
    }
    
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
        
        // dummy data for testing
        //        let email = "test@gmail.com"
        //        let userName = "user"
        //        let password =  "123456"
        let hud = JGProgressHUD(style: JGProgressHUDStyle.light)
        hud.textLabel.text = "Signup proccessing.."
        hud.show(in: self.view, animated: true)
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                print("error \(error.localizedDescription)")
                hud.dismiss(animated: true)
                return
            }
            guard let signedupUserId = result?.user.uid else {return} // that means there is a currentUser
            
            let imageName = UUID().uuidString // it's gonna give me a random string value for imageName
            
            let ref = Storage.storage().reference(withPath: "/ProfileImages/\(imageName)")
            // we need to make the image's data
            
            let imageData = self.btnAddImage.imageView?.image?.jpegData(compressionQuality: 0.8) ?? Data() // if there is no image send us to empty data
            
            ref.putData(imageData, metadata: nil) { (_, error) in // probably we put imegadata to ref point and we get it in downloadU
                if let error = error {
                    print("Error---\(error.localizedDescription)") 
                    return
                }
                //                print("image uploaded successfully..")
                
                ref.downloadURL { (url, error) in //here is important and actually I didn't understand that where came from url??
                    if let error = error{
                        print("Error****\(error)")
                        return
                    }
                    //                    print("the url of the image\(url?.absoluteString)")
                    
                    let dataToAdd : [String:Any] = ["UserName": userName,"UserID": signedupUserId, "ProfileImageUrl": url?.absoluteString as Any]
                    
                    Firestore.firestore().collection("Users").document(signedupUserId).setData(dataToAdd) { (error) in
                        if let error = error{
                            print("User data didn't save to Firestore \(error.localizedDescription)")
                        }
                        print("User data saved successfully")
                        hud.dismiss(animated: true)
                        self.fixImageView()
                        let keyWindow = UIApplication.shared.connectedScenes
                            .filter({$0.activationState == .foregroundActive})
                            .map({$0 as? UIWindowScene})
                            .compactMap({$0})
                            .first?.windows
                            .filter({$0.isKeyWindow}).first
                        
                        guard let mainTabBarController = keyWindow?.rootViewController as? MainTabBarController else {return} // as a default => it's UIViewController. Also you can go SceneDelegate and can see there that ' self.window?.rootViewController = MainTabBarController() ' we did it before.
                        
                        mainTabBarController.showProfileView() // with that way we can reach the func inside of MainTabBarController..
                        self.dismiss(animated: true, completion: nil) // with this, this view gonna close id it does not we can't see the other views
                        
                    }
                }
            }
            
            
            //            print("user account created. id: \(result?.user.uid)")
            
        }
        
    }
    
    fileprivate func fixImageView(){ // actually we don't need this one. becuse this one just was a step in the begining
        //        self.btnAddImage.imageView?.image = #imageLiteral(resourceName: "addImage")
        self.btnAddImage.setImage(#imageLiteral(resourceName: "addImage"), for: .normal)
        self.btnAddImage.layer.borderColor = UIColor.clear.cgColor
        self.btnAddImage.layer.borderWidth = 0
        self.txtEmail.text = ""
        self.txtPassword.text = ""
        self.txtUserName.text = ""
        let hudSuccess = JGProgressHUD(style: .light)
        hudSuccess.textLabel.text = "Signup successful.."
        hudSuccess.show(in: self.view, animated: true)
        hudSuccess.dismiss(afterDelay: 2)
        
    }
    
    let btnGoSignIn: UIButton = {
        let btn = UIButton(type: .system)
        let attrTitle = NSMutableAttributedString(string: "Do you have already an account?", attributes: [
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        attrTitle.append(NSAttributedString(string: " Sign In.", attributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16),
            .foregroundColor: UIColor.ConvertRgb(red: 20, green: 155, blue: 235)]))
        btn.setAttributedTitle(attrTitle, for: .normal)
        btn.addTarget(self, action: #selector(btnGoSignInClicked), for: .touchUpInside)
        return btn
    }()
    
    @objc fileprivate func btnGoSignInClicked(){
        
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
        
        view.addSubview(btnAddImage)
        //        view.addSubview(txtEmail)
        
        //        btnAddImage.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        //        btnAddImage.center = view.center
        
        //we did it isActive because we want to work the constraints which we gave here
        //        btnAddImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        //        btnAddImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        btnAddImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //        btnAddImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        // we said that safeAreaLayoutGuide-> it's gonna take safe area frame because before it was superview frame
        btnAddImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: nil, trailing: nil, paddingTop: 40, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 150, height: 150)
        
        //we can write it also with this way without writing isActive=true everytime
        //        NSLayoutConstraint.activate([
        //            txtEmail.topAnchor.constraint(equalTo: btnAddImage.bottomAnchor, constant: 20),
        //            txtEmail.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
        //            txtEmail.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
        //            txtEmail.heightAnchor.constraint(equalToConstant: 50)
        //        ])
        
        createSignField()
        
        view.addSubview(btnGoSignIn)
        btnGoSignIn.anchor(top: nil, bottom: view.safeAreaLayoutGuide.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 60)
        
    }
    
    fileprivate func createSignField(){
        //        let redView = UIView()
        //        redView.backgroundColor = .red
        //        let blueView = UIView()
        //        blueView.backgroundColor = .blue
        
        let stackView = UIStackView(arrangedSubviews: [txtEmail,txtUserName,txtPassword,btnSignup]) //[redView,blueView] we checked it out with this way
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        //        NSLayoutConstraint.activate([ //we added the anchor method for an extention in the viewCLass and we use it below instead of this method
        //            stackView.topAnchor.constraint(equalTo: btnAddImage.bottomAnchor, constant: 20),
        //            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
        //            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
        //            stackView.heightAnchor.constraint(equalToConstant: 230)
        //        ])
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
        translatesAutoresizingMaskIntoConstraints = false// this is improtant because without it our constraints don't show up in the view
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

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    //if user click the cancel button
    
    func didChangeValue<Value>(for keyPath: KeyPath<SignUpController, Value>) {
        dismiss(animated: true, completion: nil)
    }
    
    // it doesn't need calling from anywhere it's gonna execute when the user pick the image from library.
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[.originalImage] as? UIImage
        self.btnAddImage.setImage(chosenImage?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), for: .normal)
        btnAddImage.layer.cornerRadius = btnAddImage.frame.width / 2
        btnAddImage.layer.masksToBounds = true
        btnAddImage.layer.borderColor = UIColor.darkGray.cgColor
        btnAddImage.layer.borderWidth = 3
        dismiss(animated: true, completion: nil)// with this the photolibrary goes away from view..
    }
    
}

