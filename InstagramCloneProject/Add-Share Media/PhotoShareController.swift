//
//  SharePhotoController.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 26/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import UIKit

class PhotoShareController: UIViewController {
    
    var selectedPhoto: UIImage?
    
    let imgShare:UIImageView = {
        let img = UIImageView()
        img.backgroundColor = .blue
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.ConvertRgb(red: 240, green: 240, blue: 240)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .plain, target: self, action: #selector(shareButtonClicked))
        
        createPhotoMessageField()
        
        
    }
    
    @objc fileprivate func shareButtonClicked(){
        print("abcd")
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    fileprivate func createPhotoMessageField(){
        let shareView = UIView()
        shareView.backgroundColor = .white
        view.addSubview(shareView)
        shareView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 120)
        
        view.addSubview(imgShare)
        imgShare.anchor(top:shareView.topAnchor , bottom: shareView.bottomAnchor, leading: shareView.leadingAnchor, trailing: nil, paddingTop: 8, paddingBottom: -8, paddingLeading: 8, paddingTrailing: 0, width: 85, height: 0)
    }
}
