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

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?,
                bottom:NSLayoutYAxisAnchor?,
                leading:NSLayoutXAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                paddingTop: CGFloat,
                paddingBottom: CGFloat,
                paddingLeading:CGFloat,
                paddingTrailing:CGFloat,
                width:CGFloat,
                height:CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false// this is improtant because without it our constraints don't show up in the view
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let bottom  = bottom {
            self.bottomAnchor.constraint(equalTo: bottom, constant: paddingBottom).isActive = true
        }
        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: leading, constant: paddingLeading).isActive = true
        }
        if let trailing = trailing{
            self.trailingAnchor.constraint(equalTo: trailing, constant: paddingTrailing).isActive = true
        }
        if width != 0 {
            self.widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if height != 0 {
            self.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
    }
}
