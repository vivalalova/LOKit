//
//  File.swift
//
//
//  Created by Lova on 2021/4/20.
//

import SwiftUI

public
extension View {
    func isShow(_ show: @autoclosure () -> Bool) -> some View {
        Group {
            if show() {
                self
            }
        }
    }

    func isHidden(hidden: @autoclosure () -> Bool) -> some View {
        self.isShow(!hidden())
    }
}
