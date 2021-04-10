//
//  WebView.swift
//  taxigo-rider-ios
//
//  Created by lova on 2020/10/29.
//

import Combine
import SwiftUI
import UIKit
import WebKit

public
struct WebView: UIViewRepresentable {
    @StateObject var model: Model

    // MARK: - variables

    var canReload = true

    /// life cycle
    var viewModel: ((Model) -> Void)?

    public
    init(model: Model, canReload: Bool = true, viewModel: ((Model) -> Void)? = nil) {
        self._model = StateObject(wrappedValue: model)

        self.canReload = canReload
        self.viewModel = viewModel
    }

    // MARK: - life cycle

    public
    func makeCoordinator() -> Coordinator {
        Coordinator(model: self.model)
    }

    public
    func makeUIView(context: Context) -> WKWebView {
        self.model.webView.uiDelegate = context.coordinator
        self.model.webView.navigationDelegate = context.coordinator
        self.model.webView.scrollView.delegate = context.coordinator

        if self.canReload {
            self.model.webView.scrollView.refreshControl = self.refreshControl()
        }

        self.reload()

        self.viewModel?(self.model)

        return self.model.webView
    }

    public func updateUIView(_ uiView: WKWebView, context con: Context) {
        //
    }

    // MARK: - private functions

    private func reload() {
        guard let u = self.model.url else {
            Console.log("nil url")
            return
        }
        Console.log("has url")

        let url = self.model.willLoad?(u) ?? u
        Console.log(url)
        self.model.webView.load(url)
    }

    private func refreshControl() -> UIRefreshControl {
        UIRefreshControl(frame: CGRect.zero, primaryAction: UIAction { [self] _ in
            self.reload()
        })
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(
            model: WebView.Model(url: URL(string: "https://google.com.tw"),
                                 startLoading: { _ in true },
                                 loadingCompleted: { _ in })
        )
    }
}
