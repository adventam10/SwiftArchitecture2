//
//  UIColor+hexColor.swift
//  SwiftArchitecture
//
//  Created by am10 on 2019/04/28.
//  Copyright © 2019 am10. All rights reserved.
//
import UIKit

public extension UIColor {
    convenience init(hexStr: String, alpha: CGFloat) {
        let hexString = hexStr.replacingOccurrences(of: "#", with: "")
        let scanner = Scanner(string: hexString)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let red = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(color & 0x0000FF) / 255.0
            self.init(red: red, green: green, blue: blue, alpha: alpha)
        } else {
            print("invalid hex string")
            self.init()
        }
    }
}
