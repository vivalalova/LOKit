//
//  WebViewModel.swift
//  taxigo-rider-ios
//
//  Created by lova on 2021/1/12.
//

import Combine
import SwiftUI
import WebKit

// MARK: - model

public
protocol Navigator {
    var webView: WKWebView { get }
}

public
extension WebView {
    final class Model: ObservableObject {
        var bag = Set<AnyCancellable>()

        public let webView: WKWebView

        @Published public var title: String = ""

        // MARK: - variables

        @Published public var url: URL?
        public var willLoad: ((URL) -> URL)?
        public let allow: ((URL) -> Bool)?
        public let blank: ((URL) -> Void)?

        /// life cycle
        ///
        /// - Parameter URL: which url will start loading
        /// - Returns: return if refreshControl animation start
        public let startLoading: (URL) -> Bool
        public let loadingCompleted: (URL) -> Void

        public
        init(navigator: Navigator? = nil, url: URL?, willLoad: ((URL) -> URL)? = nil, allow: ((URL) -> Bool)? = nil, blank: ((URL) -> Void)? = nil, startLoading: @escaping (URL) -> Bool, loadingCompleted: @escaping (URL) -> Void) {
            self.webView = navigator?.webView ?? WKWebView()

            self.url = url
            self.willLoad = willLoad
            self.allow = allow
            self.blank = blank
            self.startLoading = startLoading
            self.loadingCompleted = loadingCompleted

            self.webView.publisher(for: \.title).sink { title in
                Console.log(title: "title change", title)
                self.title = title ?? ""
            }
            .store(in: &self.bag)

//            self.webView
//                .publisher(for: \.title)
//                .map { $0 ?? "" }
//                .assign(to: \.title, on: self)
//                .store(in: &self.bag)

            self.$url.sink { url in
                Console.warning(title: "change url", url)
            }.store(in: &self.bag)
        }

//        func scrollToTop() {
//            self.webView.evaluateJavaScript("window.scrollTo(0,0)", completionHandler: nil)
//        }
    }
}
