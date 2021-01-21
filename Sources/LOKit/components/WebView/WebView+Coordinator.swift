//
//  WebView+Coordinator.swift
//  taxigo-rider-ios
//
//  Created by lova on 2020/11/6.
//

import WebKit

public
extension WebView {
    final class Coordinator: NSObject, UIScrollViewDelegate, WKUIDelegate, WKNavigationDelegate {
        private let model: WebView.Model

        init(model: WebView.Model) {
            self.model = model
        }
    }
}

// MARK: - class UIScrollViewDelegate

extension WebView.Coordinator {
    public func viewForZooming(in _: UIScrollView) -> UIView? {
        nil
    }
}

// MARK: - class WebViewUIDelegate: NSObject, WKUIDelegate

extension Notification.Name {
    static let webAlert = Notification.Name("webviewAlert")
}

extension WebView {
    final class WebAlert {
        var message: String
        var completeHandler: () -> Void
        init(message: String, completeHandler: @escaping () -> Void) {
            self.message = message
            self.completeHandler = completeHandler
        }
    }
}

extension WebView.Coordinator {
    public func webView(_: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame _: WKFrameInfo, completionHandler: @escaping () -> Void) {
        Console.info(title: "alert", message)
        // Alertift.alert(title: nil, message: message)
        //  .action(.cancel(R.string.localizable.ok())) {
        //      completionHandler()
        //  }
        //  .show(on: self, completion: nil)
        let webAlert = WebView.WebAlert(message: message, completeHandler: completionHandler)
        NotificationCenter.default.post(name: .webAlert, object: webAlert, userInfo: [
            "message": message,
            "completionHandler": completionHandler
        ])
    }

    public func webView(_: WKWebView, createWebViewWith _: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures _: WKWindowFeatures) -> WKWebView? {
        Console.log("createWebViewWith for windowFeatures")
        guard let url = navigationAction.request.url, UIApplication.shared.canOpenURL(url) else {
            return nil
        }

        return nil
    }
}

// MARK: - WebViewNavigationDelegate: NSObject, WKNavigationDelegate

extension WebView.Coordinator {
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        Console.log("didStartProvisionalNavigation")

        if let url = webView.url {
            let animate = self.model.startLoading(url)
            if animate {
                DispatchQueue.main.async {
                    webView.scrollView.refreshControl?.beginRefreshing()
                }
            }
        }
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        Console.log("didFail")

        if let url = webView.url {
            self.model.loadingCompleted(url)
        }

        DispatchQueue.main.async {
            webView.scrollView.refreshControl?.endRefreshing()
        }
    }

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        Console.log("didFinish \(webView.url?.absoluteString ?? "")")

        if let url = webView.url {
            self.model.loadingCompleted(url)
        }

        DispatchQueue.main.async {
            webView.scrollView.refreshControl?.endRefreshing()
        }
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        Console.log("decidePolicyFor")

        guard
            navigationAction.request.url?.absoluteString != "about:blank",
            let url = navigationAction.request.url,
            self.model.allow?(url) ?? true
        else {
            Console.warning("loading denied \(navigationAction.request.url?.absoluteString ?? "")")
            decisionHandler(.cancel)
            return
        }

        self.model.url = url
        decisionHandler(.allow)
    }
}
