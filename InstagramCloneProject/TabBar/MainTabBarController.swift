//
//  MainTabBarController.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 20/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class MainTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        self.delegate = self // it's really important!!! for UITabBarControllerDelegate
        
        if Auth.auth().currentUser == nil{
            // there is no user signed in
            DispatchQueue.main.async {
                let signInController = SignInController()
                let navController = UINavigationController(rootViewController: signInController)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
            return
        }
        
        showProfileView()
    }
    
    func showProfileView(){
        
//        let mainController = UIViewController()
//        let mainNavController = UINavigationController(rootViewController: mainController)
//        mainNavController.tabBarItem.image = UIImage(systemName: "house")
//        mainNavController.tabBarItem.selectedImage  = UIImage(systemName: "house.fill")
//
//        let searchController = UIViewController()
//        let searchNavController = UINavigationController(rootViewController: searchController)
//        searchNavController.tabBarItem.image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .light))
//        searchNavController.tabBarItem.selectedImage = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))
        
        let mainNavController = createNavController(image: UIImage(systemName: "house")!, selectedImage: UIImage(systemName: "house.fill")!, rootViewController: UserProfileController(collectionViewLayout: UICollectionViewFlowLayout()))
        let searchNavController = createNavController(image: UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .light))!, selectedImage: UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .semibold))!)
        let addNavController = createNavController(image: UIImage(systemName: "plus.app")!, selectedImage: UIImage(systemName: "plus.app.fill")!)
        let likeNavController = createNavController(image: UIImage(systemName: "heart")!, selectedImage: UIImage(systemName: "heart.fill")!)
        
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let userNavController = UINavigationController(rootViewController: userProfileController  )
        userNavController.tabBarItem.image = UIImage(systemName: "person")
        userNavController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        tabBar.tintColor = .black
        //         viewControllers = [navController,UIViewController()]
        viewControllers = [mainNavController, searchNavController, addNavController, likeNavController, userNavController]
        
//        guard let items = tabBar.items else {return}
//
//        for item in items{
//            print(">>>>>>>>>>>>>>>>>>>>>>>..............")
//            item.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
//        }
        
    }
    
    
    fileprivate func createNavController(image:UIImage, selectedImage:UIImage, rootViewController:UIViewController = UIViewController()) ->UINavigationController{
        let rootController = rootViewController
        let navController = UINavigationController(rootViewController: rootController)
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage =  selectedImage
        return navController
    }
    
}

extension MainTabBarController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = viewControllers?.firstIndex(of: viewController) else {return true}
        if index == 2 {
            let layout = UICollectionViewFlowLayout()
            let photoSelectController = PhotoSelectController(collectionViewLayout: layout)
            let navController = UINavigationController(rootViewController: photoSelectController)
            navController.modalPresentationStyle = .fullScreen
            present(navController, animated: true, completion: nil)
            return false
        }
        return true
    }
}
