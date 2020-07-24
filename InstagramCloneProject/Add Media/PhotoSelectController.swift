//
//  PhotoSelectController.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 23/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import UIKit

class PhotoSelectController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        collectionView.backgroundColor = .yellow
        addButtons()
    }

    override var prefersStatusBarHidden: Bool { // it doesn't work at first we need config navbar
        return true
    }
    
    fileprivate func addButtons(){
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonClicked))
    }
    @objc func cancelButtonClicked(){
        dismiss(animated: true, completion: nil) // when you press it, it dismiss current view immediately
    }

}

extension UINavigationController{
    open override var childForStatusBarHidden: UIViewController?{
        return self.topViewController
    }
}
