//
//  LessonView.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/26/24.
//

import SwiftUI
import WebKit

struct LessonView: UIViewRepresentable {
    var htmlFileName: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        
        // Use URL-based loading
        if let fileURL = Bundle.main.url(forResource: htmlFileName, withExtension: "html") {
            webView.loadFileURL(fileURL, allowingReadAccessTo: fileURL)
        } else {
            // Show error if file cannot be loaded
            let errorMessage = """
            <html>
            <body><h2>Error: Could not load \(htmlFileName).html</h2></body>
            </html>
            """
            webView.loadHTMLString(errorMessage, baseURL: nil)
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // No update needed
    }
}
