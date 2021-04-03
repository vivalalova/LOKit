//
//  SFSymbol.swift
//  IPCameras
//
//  Created by Lova on 2021/4/4.
//

import SwiftUI

public
enum SFSymbol: String, View {
    case location

    public var body: some View {
        Image(systemName: self.rawValue)
    }
}
