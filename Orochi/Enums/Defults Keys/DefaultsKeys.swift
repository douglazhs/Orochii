//
//  DefaultsKeys.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 12/07/23.
//

import Foundation

/// Default app User Defaults keys
public struct DefaultsKeys {
    public enum Settings: String {
        case sync = "settings.icloud.sync"
        case biometry = "settings.biometry"
        case library = "settings.biometry.library"
        case secLevel = "settings.biometry.secLevel"
        case lockState = "settings.biometry.lockState"
        case chUpdate = "settings.chUpdate"
    }
    
    public enum SrcPreferences: String {
        case languages = "srcPreferences.languages"
        case quality = "srcPreferences.quality"
        case nsfw = "srcPreferences.nsfw"
    }
    
    public enum ReaderPreferences: String {
        case pageLayout = "readerPreferences.pageLayout"
        case mode = "readerPreferences.mode"
    }
    
    public enum Chapters: String {
        case order = "chapters.order"
        case downloaded = "chapters.downloaded"
    }
}
