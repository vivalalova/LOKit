//
//  BottomBUtton.swift
//
//  Created by Lova on 2019/11/24.
//

import SwiftUI

public
struct BottomButton<Content: View>: View {
    let title: String
    let fontColor: Color
    let bgColor: Color
    let pressed: () -> Void

    let cover: () -> Content?

    public
    init(title: String = "", fontColor: Color = .white, bgColor: Color = .yellow, pressed: @escaping () -> Void = {}, @ViewBuilder content: @escaping () -> Content? = { nil }) {
        self.title = title
        self.fontColor = fontColor
        self.bgColor = bgColor
        self.pressed = pressed
        self.cover = content
    }

    public
    var body: some View {
        Button(action: self.pressed, label: {
            if let content = cover() {
                content
                    .frame(maxWidth: .infinity)
            } else {
                label
                    .frame(maxWidth: .infinity)
            }
        })
            .frame(maxWidth: .infinity)
            .frame(height: 44)
            .foregroundColor(self.fontColor)
            .background(self.bgColor)
            .cornerRadius(8)
    }

    private var label: some View {
        Text(self.title)
            .font(.title3)
            .frame(maxWidth: .infinity)
    }
}

struct BottomButton_Previews: PreviewProvider {
    @State var fontColor = Color.white
    @State var bgColor = Color.black

    static var previews: some View {
        ZStack {
            Color.green
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()

                Text("HIHI").font(.largeTitle)

                Spacer()

                BottomButton(title: "Login", content: {})
                    .padding()
            }
        }
    }
}
