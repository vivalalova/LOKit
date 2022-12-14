//
//  LogLevel.swift

//
//  Created by lova on 2020/12/9.
//

import SwiftUI

// 🟥🟧🟨🟩🟦🟪⬛️⬜️🟫🔷🔳🔺🔻💔

public
extension Console {
    enum LogLevel: Int, CaseIterable, Identifiable {
        public var id: Int {
            self.rawValue
        }

        case verbose
        case debug
        case info
        case warning
        case error
        case none

        var string: String {
            switch self {
            case .verbose:
                return "verbose"
            case .debug:
                return "debug"
            case .info:
                return "info"
            case .warning:
                return "warning"
            case .error:
                return "error"
            case .none:
                return ""
            }
        }

        var color: Color {
            switch self {
            case .verbose:
                return .black
            case .debug:
                return .gray
            case .info:
                return .green
            case .warning:
                return .yellow
            case .error:
                return .red
            case .none:
                return .white
            }
        }

        var rect: String {
            switch self {
            case .verbose:
                return "⬛️"
            case .debug:
                return "⬜️"
            case .info:
                return "🟩"
            case .warning:
                return "🟨"
            case .error:
                return "🟥"
            case .none:
                return ""
            }
        }
    }
}
