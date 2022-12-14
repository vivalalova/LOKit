//
//  File.swift
//
//
//  Created by Lova on 2021/1/21.
//

import SwiftUI

public
protocol Chainable {}

public
extension Chainable {
    @discardableResult
    func config(_ config: (Self) -> Void) -> Self {
        config(self)
        return self
    }
}

extension NSObject: Chainable {}
