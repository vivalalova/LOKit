//
//  Application.swift
//  taxigo-rider-ios
//
//  Created by lova on 2020/12/8.
//

import UIKit

public
extension Notification.Name {
    var publisher: NotificationCenter.Publisher {
        NotificationCenter.default.publisher(for: self)
    }
}
