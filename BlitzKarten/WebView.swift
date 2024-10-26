//
//  WebView.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/26/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var htmlFileName: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let htmlPath = Bundle.main.path(forResource: htmlFileName, ofType: "html"),
           let htmlData = try? Data(contentsOf: URL(fileURLWithPath: htmlPath)),
           let htmlString = String(data: htmlData, encoding: .utf8) {
            webView.loadHTMLString(htmlString, baseURL: nil)
        }
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        // No update needed for static HTML content
    }
}
