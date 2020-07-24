//
//  PhotoSelectCell.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 24/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import UIKit

class PhotoSelectCell: UICollectionViewCell{
    let imgPhoto: UIImageView = {
       let img = UIImageView()
        img.backgroundColor = .green
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        return img
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        
        addSubview(imgPhoto)
        imgPhoto.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor, paddingTop: 0, paddingBottom: 0, paddingLeading: 0, paddingTrailing: 0, width: 0, height: 0)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
