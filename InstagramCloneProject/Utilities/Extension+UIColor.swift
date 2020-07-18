//
//  Extension+UIColor.swift
//  InstagramCloneProject
//
//  Created by halil ibrahim baykan on 18/07/2020.
//  Copyright © 2020 halil ibrahim baykan. All rights reserved.
//

import Foundation
import UIKit

extension UIColor{
    
    static func ConvertRgb(red: CGFloat, green: CGFloat,  blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    
}
