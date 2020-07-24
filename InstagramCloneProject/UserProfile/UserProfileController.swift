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
    
    let sharedCellId = "sharedCellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
//        navigationItem.title = "User Profile"
        
        getUser()
        
        collectionView.register(UserProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerID") // we created header and registered to collectionview. because we created it manually. collectionView daosn't have header footer.
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: sharedCellId) // also we registered cell
        
        btnSignOut()
    }
    
    fileprivate func btnSignOut(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(signOut))
    }
    
    @objc func signOut(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        present(alert, animated: true, completion: nil)
        let actionSignOut = UIAlertAction(title: "Sign Out", style: .destructive) { (_) in
            print("signing out.. ")
            
            guard let _ = Auth.auth().currentUser?.uid else {return}
            do{
                try Auth.auth().signOut()
                let signInController = SignInController()
                let navController = UINavigationController(rootViewController: signInController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }catch {
                print("sign out error")
            }
            
        }
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(actionSignOut)
        alert.addAction(actionCancel)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width-5) / 3
        return CGSize(width: width, height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: sharedCellId, for: indexPath)
        cell.backgroundColor = .blue
        
        
        return cell
    }
    
    // we create header for supplement to this class an
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //this line is similar with cell logic this is just dequeue..SupplementaryView
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerID", for: indexPath) as! UserProfileHeader
        header.currentUser = currentUser // send currentUser to UserProfileHeader Class
//        header.backgroundColor = .green
        return header
    }
    
    
    
    fileprivate func getUser(){
        guard let currentUserId = Auth.auth().currentUser?.uid else {return}
        Firestore.firestore().collection("Users").document(currentUserId).getDocument { (snapshot, error) in
            if let error = error{
                print("Can't get user data \(error.localizedDescription)")
            }
            
            guard let userData = snapshot?.data() else{return} // checking there is data in that snapshot..
//            let userName = userData["UserName"] as? String
            self.currentUser = User(userData: userData) // we get the currentUser from database here.. we parsing it to sending User model.
            // header field reload and the really point here that we can do some adjusments inside header..
            
            //** now I understand that we assign self.currentUser = User(userData: userData) we should reload because we want to send it to the cell and it writin in the method above but first viewDidLoad it was emty after reloading the view, it's gonna be full and it goes to headerCell and header can show our data  with that way.
            
            self.collectionView.reloadData() // we have to reload it because after this view stood up we sending some data to cell and if we want to see those data which we sent hust know we should reload collectionview again, I guess :)
            
//            print(self.currentUser?.userName ?? "","-------") // if reloadData being comment cureentUser, it's coming here but not going there because....?
//            let userId = userData["UserID"]
            self.navigationItem.title = self.currentUser?.userName
//            print(currentUserId)
            
        }
    }
}


extension UserProfileController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 200) // we gave it  width and height here
    }
    // also, this is for footer
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//        <#code#>
//    }

    
}
