//
//  Extentions.swift
//  Messenger
//
//  Created by Pavel Burdukovskii on 10/05/2018.
//  Copyright © 2018 Pavel Burdukovskii. All rights reserved.
//

import Foundation
import UIKit
//extension UIColor {
//    struct inputButtonCollor{
//      static let backgroundColor = UIColor(red: 0xCF, green: 0x1F, blue: 0x28, alpha: 1)
//      static let shadow = UIColor(red: 0xE4, green: 0x22, blue: 0x2D, alpha: 0.5).cgColor
////        static let shadow = CGColor(colorSpace: CGColorSpace, components: <#T##UnsafePointer<CGFloat>#>)
//    }
//}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alfa : CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: (alfa))
    }
    
    convenience init(rgb: Int, alfa : CGFloat) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF,
            alfa: alfa
        )
    }
}
