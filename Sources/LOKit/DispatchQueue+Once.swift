//
//  DispatchQueue+Once.swift

//
//  Created by lova on 2020/12/17.
//

import Foundation

public extension DispatchQueue {
    private static var _onceTracker = [String]()
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    class func once(token: String, block: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        if self._onceTracker.contains(token) {
            return
        }
        self._onceTracker.append(token)
        block()
    }
}
