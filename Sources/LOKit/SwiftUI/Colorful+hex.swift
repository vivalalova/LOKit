//
//  File.swift
//
//
//  Created by lova on 2021/1/14.
//

import SwiftUI

public
extension Color {
    init(hex: String) {
        let (a, r, g, b) = hexFor(hex)

        self.init(.sRGB, red: Double(r) / 255, green: Double(g) / 255, blue: Double(b) / 255, opacity: Double(a) / 255)
    }
}

public
extension UIColor {
    convenience init(hex: String) {
        let (_, r, g, b) = hexFor(hex)
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)
    }
}

// https://stackoverflow.com/a/56874327
func hexFor(_ hex: String) -> (UInt64, UInt64, UInt64, UInt64) {
    let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
    var int: UInt64 = 0
    Scanner(string: hex).scanHexInt64(&int)

    switch hex.count {
    case 3: // RGB (12-bit)
        return (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
    case 6: // RGB (24-bit)
        return (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
    case 8: // ARGB (32-bit)
        return (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
    default:
        return (1, 1, 1, 0)
    }
}
