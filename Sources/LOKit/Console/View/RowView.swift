//
//  Row.swift

//
//  Created by lova on 2020/12/15.
//

import Combine
import SwiftUI

extension Console {
    struct Row: View {
        @State var record: Console.Record

        var body: some View {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    VStack(alignment: .trailing) {
                        Text(record.time, style: .time)
                        Text(record.level.rect)
                    }
                    Divider()

                    VStack(alignment: .leading) {
                        if let title = record.title {
                            Text(title)
                        }

                        Text(record.content)
                            .lineLimit(5)
                    }
                }

                Divider()
            }.padding(.horizontal, 4)
        }
    }
}

struct Row_Previews: PreviewProvider {
    static var record = Console.Record(title: "title", message: ["hihi"], level: .error, file: "", function: "", line: 0)

    static var previews: some View {
        Console.Row(record: record)
            .previewLayout(.sizeThatFits)
    }
}
