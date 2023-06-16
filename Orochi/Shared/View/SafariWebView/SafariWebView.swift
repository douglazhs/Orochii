//
//  SafariWebView.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 30/05/23.
//

import SwiftUI
import SafariServices
 
/// SwiftUI Safari WebView
struct SafariWebView: UIViewControllerRepresentable {
    let url: URL
 
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
 
    func updateUIViewController(_ webView: SFSafariViewController, context: Context) {
        
    }
}
