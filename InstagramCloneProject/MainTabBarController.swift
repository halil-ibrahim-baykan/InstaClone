//
//  MainTabBarController.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 20/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .blue
        
//        let yellowVC = UIViewController()
//        yellowVC.view.backgroundColor = .yellow
        let layout = UICollectionViewFlowLayout()
        let userProfileController = UserProfileController(collectionViewLayout: layout)
        let navController = UINavigationController(rootViewController: userProfileController  )
        navController.tabBarItem.image = UIImage(systemName: "person")
        navController.tabBarItem.selectedImage = UIImage(systemName: "person.fill")
        tabBar.tintColor = .black
        viewControllers = [navController,UIViewController()]
    }
    
    
}

