//
//  String+attributedString.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 20/06/23.
//

import Foundation

extension String {
    func convertToAttributedFromHTML() -> NSAttributedString? {
        var attributedText: NSAttributedString?
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        if let data = data(using: .unicode, allowLossyConversion: true),
            let attrStr = try? NSAttributedString(
            data: data,
            options: options,
            documentAttributes: nil
        ) {
            attributedText = attrStr
        }
        return attributedText
    }
    
    var attributedString: AttributedString {
        do {
            return try AttributedString(markdown: self)
        } catch {
            print(error.localizedDescription)
        }
        return AttributedString(self)
    }
}
