//
//  SearchBarView.swift

//
//  Created by lova on 2020/12/15.
//

import SwiftUI

public
extension Console {
    struct SearchBar: View {
        @Binding var text: String
        @State private var isEditing = false

        func onEditing() {
            withAnimation {
                self.isEditing = true
            }
        }

        fileprivate func onEndEditing() {
            UIApplication.shared.dismissKeyboard()

            withAnimation {
                self.isEditing = false
            }
        }

        public
        var body: some View {
            HStack {
                TextField("Search ...", text: self.$text)
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .onTapGesture(perform: self.onEditing)

                if isEditing {
                    Button(action: self.onEndEditing) {
                        Image(systemName: "return")
                    }
                    .padding(.trailing, 10)
                    .transition(.move(edge: .trailing))
                    .animation(.default)
                }
            }
        }
    }
}

struct SearchBarView_Previews: PreviewProvider {
    @State static var text = ""

    static var previews: some View {
        Console.SearchBar(text: $text)
            .previewLayout(.sizeThatFits)
    }
}
