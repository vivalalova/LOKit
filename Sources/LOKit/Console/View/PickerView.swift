//
//  PickerView.swift

//
//  Created by lova on 2020/12/15.
//

import SwiftUI

extension Console {
    struct PickerView: View {
        @Binding var selection: Int

        var body: some View {
            Picker(selection: $selection, label: Text("Picker"), content: {
                ForEach(Console.LogLevel.allCases) { level in
                    Text(level.string.upperFirstLetter())
                        .tag(level.rawValue)
                }
            }).pickerStyle(SegmentedPickerStyle())
                .padding(4)
                .foregroundColor(.blue)
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    @State static var selection = 0

    static var previews: some View {
        Console.PickerView(selection: $selection)
            .previewLayout(.sizeThatFits)
    }
}
