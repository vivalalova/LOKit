//
//  Logger.swift
//
//  Created by Lova on 2020/6/29.
//
import Combine
import SwiftUI

// MARK: - Notification

extension Notification.Name {
    static let LoggerAppended = NSNotification.Name(rawValue: "LoggerAppended")
}

// MARK: - 本體

public
final class Console {
    private var bag = Set<AnyCancellable>()

    public
    var logLevel: LogLevel = .debug

    public
    static let shared = Console()

    @Published var records: [Record] = []

    init() {
        UIApplication.didReceiveMemoryWarningNotification
            .publisher
            .sink { _ in
                guard self.records.count > 500 else {
                    return
                }

                let count = self.records.count - 500
                self.records.removeFirst(count)
            }
            .store(in: &self.bag)
    }
}

// MARK: - logs function

public
extension Console {
    static func verbose<T>(file: String = #file, function: String = #function, line: Int = #line, title: String? = nil, _ message: T...) {
        Console.shared.printLog(level: .verbose, file: file, function: function, line: line, title: title, message)
    }

    static func log<T>(file: String = #file, function: String = #function, line: Int = #line, title: String? = nil, _ message: T...) {
        Console.shared.printLog(level: .debug, file: file, function: function, line: line, title: title, message)
    }

    static func info<T>(file: String = #file, function: String = #function, line: Int = #line, title: String? = nil, _ message: T...) {
        Console.shared.printLog(level: .info, file: file, function: function, line: line, title: title, message)
    }

    static func warning<T>(file: String = #file, function: String = #function, line: Int = #line, title: String? = nil, _ message: T...) {
        Console.shared.printLog(level: .warning, file: file, function: function, line: line, title: title, message)
    }

    static func error<T>(file: String = #file, function: String = #function, line: Int = #line, title: String? = nil, _ message: T...) {
        Console.shared.printLog(level: .error, file: file, function: function, line: line, title: title, message)
    }
}

extension Console {
    private func printLog<T>(level: LogLevel, file: String, function: String, line: Int, title: String? = nil, _ message: [T]) {
        guard level.rawValue >= self.logLevel.rawValue else {
            return
        }

        let record = Record(title: title,
                            message: message,
                            level: level,
                            file: file.replace(pattern: "(.*)/"),
                            function: function,
                            line: line)

        print(record.description)
        self.records.append(record)
    }
}
