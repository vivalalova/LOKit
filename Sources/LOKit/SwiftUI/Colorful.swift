//
//  UIColor.swift
//  taxigo-rider-ios
//
//  Created by lova on 2020/10/30.
//

import SwiftUI

public
protocol Colorful {
    var color: Color { get }
}

extension UIColor: Colorful {
    public var color: Color { Color(self) }
}

extension String: Colorful {
    public var color: Color { Color(hex: self) }
}
