//
//  LessonView.swift
//  BlitzKarten
//
//  Created by Brenna Cooper on 10/26/24.
//

import Foundation
import SwiftUI
import WebKit

struct LessonView: UIViewRepresentable {
    var htmlFileName: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let filePath = Bundle.main.path(forResource: htmlFileName, ofType: "html"),
           let htmlData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) {
            webView.loadHTMLString(String(data: htmlData, encoding: .utf8) ?? "", baseURL: nil)
        } else {
            // Display an error message if the file could not be found
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



