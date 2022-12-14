//
//  WebView.swift

//
//  Created by lova on 2020/10/29.
//

import Combine
import SwiftUI
import UIKit
import WebKit

public
struct WebView: UIViewRepresentable {
    @EnvironmentObject var model: ViewModel

    public func makeCoordinator() -> Coordinator { Coordinator(self) }

    public func makeUIView(context: Context) -> WKWebView { self.model.webView }

    public func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.uiDelegate = context.coordinator
    }

    public init() {}
}

public extension WebView {
    class ViewModel: ObservableObject {
        private var bag = Set<AnyCancellable>()

        @Published fileprivate var webView: WKWebView

        @Published private(set) var url: String?
        @Published private(set) var title: String? = nil

        public
        init(
            webView: WKWebView = WKWebView(),
            url: String? = nil
        ) {
            self.webView = webView
            self.url = url

            self.load(self.url)

            self.webView
                .publisher(for: \.title)
                .assign(to: \.title, on: self)
                .store(in: &self.bag)

            self.webView
                .publisher(for: \.url)
                .map(\.?.absoluteString)
                .assign(to: \.url, on: self)
                .store(in: &self.bag)
        }

        @discardableResult
        public func load(_ url: String?) -> Bool {
            guard let string = url, let url = URL(string: string) else {
                return false
            }

            let request = URLRequest(url: url)
            self.webView.load(request)

            return true
        }

        public func reload() { self.webView.reload() }
        public func goBack() { self.webView.goBack() }
        public func goForward() { self.webView.goForward() }
    }
}

public extension WebView {
    class Coordinator: NSObject, WKUIDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        // Delegate methods go here

        public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            // alert functionality goes here
        }
    }
}

struct WebView_Previews: PreviewProvider {
    @State static var url: String? = "https://google.com.tw"

    static var previews: some View {
        WebView()
            .environmentObject(WebView.ViewModel(url: url))
    }
}
