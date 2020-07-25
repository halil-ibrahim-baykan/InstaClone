//
//  UserProfileHeader.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 20/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SDWebImage

class UserProfileHeader: UICollectionViewCell { // we should create a header for a CollectionView from UICollectionViewCell
    let profileImage: UIImageView = {
        let img = UIImageView()
//        img.backgroundColor = .yellow
        return img
    }()
    
    let btnGrid: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "circle.grid.3x3.fill"), for: .normal)
        return btn
    }()
    
    let btnList: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        btn.tintColor = UIColor(white:0, alpha: 0.2)
        return btn
    }()
    
    let btnBookmark: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "bookmark"), for: .normal)
        btn.tintColor = UIColor(white:0, alpha: 0.2)
        return btn
    }()
    
    let lblUserName: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    var currentUser : User?{ // when user come to currentUser which is inside of UserProfileController we said that there header.currentUser = currentUser
        didSet{
            guard let url = URL(string: currentUser?.profileImageUrl ?? "" ) else { return }
            profileImage.sd_setImage(with: url, completed: nil)
            lblUserName.text = currentUser?.userName
        }
    }
    
    let lblSharing : UILabel = {
        let lbl = UILabel()
        let attrText = NSMutableAttributedString(string: "10\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 16)])
        attrText.append(NSAttributedString(string: "Sharing", attributes: [
            .foregroundColor : UIColor.darkGray,
            .font: UIFont.systemFont(ofSize: 15)]))
        lbl.attributedText = attrText
        //        lbl.text = "10\nSharing"
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let lblFollower : UILabel = {
        let lbl = UILabel()
        let attrText = NSMutableAttributedString(string: "30\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 16)])
        attrText.append(NSAttributedString(string: "Follower", attributes: [
            .foregroundColor : UIColor.darkGray,
            .font: UIFont.systemFont(ofSize: 15)]))
        lbl.attributedText = attrText
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    let lblFollowing : UILabel = {
        let lbl = UILabel()
        let attrText = NSMutableAttributedString(string: "20\n", attributes: [.font : UIFont.boldSystemFont(ofSize: 16)])
        attrText.append(NSAttributedString(string: "Following", attributes: [
            .foregroundColor : UIColor.darkGray,
            .font: UIFont.systemFont(ofSize: 15)]))
        lbl.attributedText = attrText
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let btnEditProfile: UIButton = {
        let btn = UIButton()
        btn.setTitle("Edit Profile", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        btn.layer.borderColor = UIColor.lightGray.cgColor
        btn.layer.borderWidth = 1
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        //        backgroundColor = .red
        
        addSubview(profileImage)// we are in a cell that's why we write directly addSubView... because we don't have a view object here.
        let imageSize: CGFloat = 90
        profileImage.anchor(top: self.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: nil, paddingTop: 15, paddingBottom: 0, paddingLeading: 15, paddingTrailing: 0, width: imageSize, height: imageSize)
        profileImage.layer.cornerRadius = imageSize / 2
        profileImage.clipsToBounds = true
        //        profileImageDownload() we're gonna make this in a different way it's above inside of currentUser we are getting currentUSer objet, it comes here and we are making url and sending SDWebImage and dowloading it profile image and we reloading it in the UserProfileController and it comes into our view
        
        createToolbar() //we wrote it in a func because we put them in a stackView
        
        addSubview(lblUserName)// here it's just a single item and we made it inside override init method which doesn't make sense so much but for now it's ok :)
        lblUserName.anchor(top: profileImage.bottomAnchor, bottom: btnGrid.topAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 5, paddingBottom: 0, paddingLeading: 15, paddingTrailing: 15, width: 0, height: 0)
        
        displayUserStatus()// we wrote it in a func because we put them in a stackView
        
        addSubview(btnEditProfile)
        btnEditProfile.anchor(top: lblSharing.bottomAnchor, bottom: lblUserName.topAnchor, leading: lblSharing.leadingAnchor, trailing: lblFollowing.trailingAnchor, paddingTop: 10, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 35)
        
    }
    
    fileprivate func displayUserStatus(){
        let stackView = UIStackView(arrangedSubviews: [lblSharing,lblFollower,lblFollowing])
        addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.anchor(top: topAnchor, bottom: nil, leading: profileImage.trailingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 15, paddingTrailing: -15, width: 0, height: 50)
    }
    
    fileprivate func createToolbar(){
        let topSeparatrixView = UIView()
        topSeparatrixView.backgroundColor = .lightGray
        let bottomSeparatrixView = UIView()
        bottomSeparatrixView.backgroundColor = .lightGray
    
        let stackView = UIStackView(arrangedSubviews: [btnGrid,btnList,btnBookmark])
        addSubview(stackView)
        addSubview(topSeparatrixView)
        addSubview(bottomSeparatrixView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.anchor(top: nil, bottom: self.bottomAnchor, leading: self.leadingAnchor, trailing: self.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 60)
        // the top line for seperating
        topSeparatrixView.anchor(top:stackView.topAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0.5)
        // the bottom line for seperating
        bottomSeparatrixView.anchor(top: stackView.bottomAnchor, bottom: nil, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0.5)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // we can download the image like this but we also call data inside of Controller that's why we made a User model and we assing it to currentuser and we made another currentUSer variable in this class and we send it to that currentUser with that way to this class from controller
    
    //    fileprivate func profileImageDownload(){
    //
    //        guard let currentUserId = Auth.auth().currentUser?.uid else {
    //            return
    //        }
    //
    //        Firestore.firestore().collection("Users").document(currentUserId).getDocument { (snapshot, error) in
    //            if let error = error{
    //                print("can't get current user data\(error.localizedDescription)")
    //            }
    //
    //            guard let userData = snapshot?.data() else {return}
    //            guard let userProfileImageUrl = userData["ProfileImageUrl"] as? String else {return}
    //            guard let url = URL(string: userProfileImageUrl) else { return}
    //
    //            // show image on view Manually
    ////            URLSession.shared.dataTask(with: url) { (data, response, error) in
    ////                if let error = error{
    ////                    print("cant download image\(error)")
    ////                }
    ////                print(data)
    ////                guard let data = data else {return}
    ////                let image = UIImage(data: data)
    ////
    ////                DispatchQueue.main.async {
    ////                    self.profileImage.image = image
    ////                }
    ////            }.resume()
    //            // with a library
    //
    //            self.profileImage.sd_setImage(with: url, completed: nil)
    //        }
    //    }
    
    
}
