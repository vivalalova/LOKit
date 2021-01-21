//
//  WKWebView.swift
//  taxigo-rider-ios
//
//  Created by lova on 2020/11/2.
//

import WebKit

public
extension WKWebView {
    func load(_ url: URL) {
        Console.log("webview loading \(url.absoluteString)")
        let request = URLRequest(url: url)
        self.load(request)
    }
}
