//
//  ContentView.swift
//  Webview
//
//  Created by Connor McClanahan on 15/11/2023.
//
import SwiftUI
import WebKit

struct ContentView: View {
    @State private var showWebView = false
    @State private var showAlert = false
    @State private var alertMessage = "Hello from WebView"
    @State private var searchText = ""
    @State private var webView: WKWebView = WKWebView()

    let initialHtmlString = """
        <!DOCTYPE html>
        <html>
        <head>
            <title>Hello, world!</title>
            <meta name="viewport" content="width=device-width, initial-scale=1">
        </head>
        <body>
            <h1>Hello, world!</h1>
            <p>Welcome to my webpage.</p>
            <script>
            function HelloFromiOS() {
                alert("Hello from a webview");
            }
            </script>
        </body>
        </html>
        """

    var body: some View {
        VStack {
            if showWebView {
                // Navigation Controls
                HStack {
                    Button(action: { webView.goBack() }) {
                        Image(systemName: "arrow.left")
                        .padding()
                    }
                    Button(action: { webView.goForward() }) {
                        Image(systemName: "arrow.right")
                        .padding()
                    }
                }

                // Search Bar
                HStack {
                    TextField("Search", text: $searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()

                    Button("Search") {
                        searchWeb(query: searchText)
                    }
                }

                // WebView
                WebView(htmlString: initialHtmlString, webView: webView, showAlert: $showAlert, alertMessage: $alertMessage)
                    .frame(height: 500)

                Button(action: {
                    showWebView = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .padding()
                }
            }

            Button("Show WebView") {
                showInitialContent()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func showInitialContent() {
        webView.loadHTMLString(initialHtmlString, baseURL: nil)
        showWebView = true
        showAlert = true // Trigger the alert when WebView is shown
    }

    func searchWeb(query: String) {
        if let url = URL(string: "https://www.google.com/search?q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}

// WebView struct as defined earlier...
