//
//  File.swift
//
//
//  Created by Lova on 2021/4/5.
//

import SwiftUI

public
struct MapView_LibraryContent: LibraryContentProvider {
    static var views: [LibraryItem] {
        [LibraryItem(MapView())]
    }
}
