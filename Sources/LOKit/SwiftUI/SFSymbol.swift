//
//  SFSymbol.swift
//  IPCameras
//
//  Created by Lova on 2021/4/4.
//

import SwiftUI

public
enum SFSymbol: String, View, CaseIterable {
    case location
    case locationFill = "location.fill"
    case locationNorth = "location.north.fill"

    public var body: some View {
        Image(systemName: self.rawValue)
    }
}

struct SFSymbol_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SFSymbol.locationFill
                .previewLayout(.sizeThatFits)
            SFSymbol.location
                .previewLayout(.sizeThatFits)
        }
    }
}
