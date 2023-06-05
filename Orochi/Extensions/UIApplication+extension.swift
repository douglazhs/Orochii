//
//  UIApplication+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 27/11/22.
//

import UIKit
import SafariServices

extension UIApplication {
    /// App version
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
    
    /// App build number
    static var appBuild: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as? String
    }
    
    /// Grab root view controller
    var firstKeyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .filter { $0.activationState == .foregroundActive }
            .first?
            .keyWindow
    }
    
    /// Present SFSafariViewController like in UIKit
    /// - Parameter url: Site URL
    func safariVC(url: String) {
        let vc = SFSafariViewController(url: URL(string: url)!)
        UIApplication.shared.firstKeyWindow?
            .rootViewController?
            .present(vc, animated: true)
    }
    
    
    /// Called when uder end editing
    func endEditing() {
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
