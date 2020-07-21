//
//  User.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 20/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import Foundation

struct User {
    let userName: String
    let userId: String
    let profileImageUrl: String
    init(userData: [String:Any]) {
        self.userName = userData["UserName"] as? String ?? ""
        self.userId = userData["UserID"] as? String ?? ""
        self.profileImageUrl = userData["ProfileImageUrl"] as? String ?? ""
    }
}
