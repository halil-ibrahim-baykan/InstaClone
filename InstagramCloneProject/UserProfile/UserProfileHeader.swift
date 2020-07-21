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

class UserProfileHeader: UICollectionViewCell {
    
    let btnGrid: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(systemName: "circle.grid.3x3.fill"), for: .normal)
        return btn
    }()
    
    let btnList: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        return btn
    }()
    
    let btnBookmark: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(systemName: "bookmark"), for: .normal)
        return btn
    }()
    
    var currentUser : User?{
        didSet{
            guard let url = URL(string: currentUser?.profileImageUrl ?? "" ) else { return }
            profileImage.sd_setImage(with: url, completed: nil)
        }
    }
    
    let profileImage: UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .yellow
        return img
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        addSubview(profileImage)
        let imageSize: CGFloat = 90
        profileImage.anchor(top: self.topAnchor, bottom: nil, leading: self.leadingAnchor, trailing: nil, paddingTop: 15, paddingBottom: 0, paddingLeading: 15, paddingTrailing: 0, width: imageSize, height: imageSize)
        profileImage.layer.cornerRadius = imageSize / 2
        profileImage.clipsToBounds = true
//        profileImageDownload() we're gonna make this in a different way it's above inside of currentUser we are getting currentUSer objet, it comes here and we are making url and sendin SDWebImage and dowloading it profile image and we reloading it in the UserProfileController and it comes into our view
        
//        toolBarCreate()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
