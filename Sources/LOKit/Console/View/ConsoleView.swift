//
//  ConsoleView.swift

//
//  Created by lova on 2020/12/9.
//

import Combine
import SwiftUI

public
extension Console {
    struct Scene: View {
        @State var pickSelection: Int = 0

        var dataSource: [Console.Record] {
            Console.shared.records
                .filter { $0.level.rawValue >= self.pickSelection }
                .filter {
                    self.filterString.count == 0
                        || $0.title?.localizedCaseInsensitiveContains(self.filterString) == true
                        || $0.content.localizedCaseInsensitiveContains(self.filterString)
                }
                .reversed()
        }

        @State var filterString = ""

        public
        init() {}

        public var body: some View {
            TabView {
                NavigationView {
                    VStack {
                        Console.PickerView(selection: self.$pickSelection)

                        Console.SearchBar(text: self.$filterString)

                        ScrollView {
                            LazyVStack(alignment: .leading) {
                                ForEach(self.dataSource) { record in
                                    NavigationLink(destination: Console.Detail(record: record)) {
                                        Console.Row(record: record)
                                    }.accentColor(.primary)
                                }
                            }
                        }
                    }.navigationBarTitle("Console", displayMode: .inline)
                }.tabItem {
                    Image(systemName: "printer.dotmatrix")
                    Text("console")
                }
            }
        }
    }
}

struct ConsoleView_Previews: PreviewProvider {
    static var previews: some View {
        Console.Scene()
            .previewLayout(.sizeThatFits)
    }
}
