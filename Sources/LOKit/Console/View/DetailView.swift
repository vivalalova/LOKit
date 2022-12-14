//
//  DetailView.swift

//
//  Created by lova on 2020/12/15.
//

import Combine
import SwiftUI

extension Console {
    struct Detail: View {
        @State var record: Console.Record

        var title: String {
            "\(self.record.level.rect) Console \(self.record.level.rect)"
        }

        var body: some View {
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("File:").foregroundColor(.gray) + Text(record.file)
                    Text("Line:").foregroundColor(.gray) + Text("\(record.line)")
                    Text("Function:").foregroundColor(.gray) + Text(record.function)
                }

                Divider()

                ScrollView {
                    ScrollView(.horizontal) {
                        Text(record.content).lineLimit(1000)
                    }
                }
                .navigationBarItems(trailing: Text(record.time, style: .time))
                .navigationBarTitle(self.title, displayMode: .inline)
            }.padding(.horizontal, 4)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var record = Console.Record(title: "the title", message: ["hihi", URL(string: "https://google")], level: .error, file: "./file", function: "func", line: 0)

    static var previews: some View {
        Console.Detail(record: record)
            .previewLayout(.sizeThatFits)
    }
}
