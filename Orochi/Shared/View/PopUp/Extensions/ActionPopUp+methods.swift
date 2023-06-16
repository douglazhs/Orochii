//
//  PopUpView+methods.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 03/12/22.
//

import UIKit

extension ActionPopUp {
    func frame(
        of title: String,
        and message: String
    ) -> CGFloat{
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.sizeToFit()
        messageLabel.text = message
        messageLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        messageLabel.sizeToFit()
        if titleLabel.frame.size.width > messageLabel.frame.size.width {
            return titleLabel.frame.size.width
        }
        return messageLabel.frame.size.width
    }
}
