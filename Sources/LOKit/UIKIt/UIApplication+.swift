//
//  UIApplication+.swift
//  taxigo-rider-ios
//
//  Created by lova on 2020/12/10.
//

import UIKit

public
extension UIApplication {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
