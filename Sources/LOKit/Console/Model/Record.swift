//
//  Record.swift

//
//  Created by lova on 2020/12/9.
//

import Foundation

public
extension Console {
    struct Record: Identifiable {
        public var id = UUID()
        var time: Date
        var level: LogLevel

        var title: String?
        var content: String

        var file: String
        var function: String
        var line: Int

        var description: String {
            let formatter = DateFormatter()
            formatter.dateFormat = "H:m:ss.SSS"

            let date = formatter.string(from: Date())
            let fileName = self.file.replace(pattern: "(.*)/").padding(toLength: 20, withPad: " ", startingAt: 0)
            let lines = "\(line)".padding(toLength: 4, withPad: " ", startingAt: 0)
            let functionName = self.function.padding(toLength: 35, withPad: " ", startingAt: 0)

            var printTitle = ""
            if let title = title {
                printTitle = "(\(title)):"
            }

            return "\(date)|\(fileName)|\(lines)|\(functionName)| \(self.level.rect) \(printTitle) \(self.content)"
        }

        init<T>(title: String?, message: [T], level: LogLevel, file: String, function: String, line: Int) {
            let string: [String] = message.map {
                if JSONSerialization.isValidJSONObject($0), let data = try? JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted), let string = String(data: data, encoding: .utf8) {
                    return string
                } else if let string = $0 as? String {
                    return string
                }

                return "\(message)"
            }

            self.time = Date()
            self.level = level
            self.title = title
            self.content = string.joined(separator: "\n\n")
            self.file = file
            self.function = function
            self.line = line
        }
    }
}
