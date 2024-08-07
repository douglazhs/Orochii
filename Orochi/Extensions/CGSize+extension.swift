//
//  CGSize+extension.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/11/22.
//

import UIKit

extension CGSize {
    /// Dynamic standard image cell size
    static var standardImageCell: CGSize {
        let portrait = UIScreen.width < UIScreen.height
        let aspectRatio = 92.5 / 62.5
        var proportion: Double {
            switch Constants.device {
            case .pad: return 0.215
            default:   return 0.285
            }
        }
        let width = (portrait ? UIScreen.width : UIScreen.height) * proportion
        return CGSize(width: width, height: width * aspectRatio)
    }
    
    /// Dynamic image size
    static var dynamicImage: CGSize {
        let portrait = UIScreen.width < UIScreen.height
        let aspectRatio = 97.5 / 67.5
        var proportion: Double {
            switch Constants.device {
            case .pad: return 0.250
            default:   return 0.425
            }
        }
        let width = (portrait ? UIScreen.width : UIScreen.height) * proportion
        return CGSize(width: width, height: width * aspectRatio)
    }
}
