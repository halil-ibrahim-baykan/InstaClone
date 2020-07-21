//
//  UserProfileController.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 20/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//
 
import Foundation
import UIKit
import Firebase



class UserProfileController: UICollectionViewController {
    
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
//        navigationItem.title = "User Profile"
        getUser()
        
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID")
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! UserProfileHeader
        header.currentUser = currentUser
//        header.backgroundColor = .green
        return header
    }
    
    
    
    fileprivate func getUser(){
        guard let currentUserId = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("Users").document(currentUserId).getDocument { (snapshot, error) in
            if let error = error{
                print("Can't get user data \(error.localizedDescription)")
            }
            
            guard let userData = snapshot?.data() else{return}
//            let userName = userData["UserName"] as? String
            self.currentUser = User(userData: userData)
            // header field reload and the really point here that we can do some adjusments inside header..
            self.collectionView.reloadData()
//            print(self.currentUser?.userName ?? "","-------") // if reloadData being comment cureentUser coming here but not going there because....?
            
//            self.navigationItem.title = currentUserId.userId
//            print(userName!)
//            let userId = userData["UserID"]
            print(currentUserId)
            
        }
    }
}


extension UserProfileController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
    

    
}
