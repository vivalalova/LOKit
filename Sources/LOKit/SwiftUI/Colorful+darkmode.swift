//
//  File.swift
//
//
//  Created by lova on 2021/1/14.
//

import SwiftUI

/// Dark mode programcally
public
class ColorMode: UIColor {
    convenience init(light: UIColor, dark: UIColor) {
        self.init { traitCollection in
            traitCollection.userInterfaceStyle == .dark ? dark : light
        }
    }

    convenience init(lightHex: String, darkHex: String) {
        self.init(light: UIColor(hex: lightHex), dark: UIColor(hex: darkHex))
    }
}
