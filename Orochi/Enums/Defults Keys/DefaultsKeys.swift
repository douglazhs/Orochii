//
//  DefaultsKeys.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 12/07/23.
//

import Foundation

protocol UserDefaultsKeys: CaseIterable { }

/// Default app User Defaults keys
public enum DefaultsKeys {
    public enum Settings: String, UserDefaultsKeys{
        case sync = "settings.icloud.sync"
        case biometry = "settings.biometry"
        case library = "settings.biometry.library"
        case secLevel = "settings.biometry.secLevel"
        case lockState = "settings.biometry.lockState"
        case chUpdate = "settings.chUpdate"
    }
    
    public enum SrcPreferences: String, UserDefaultsKeys {
        case languages = "srcPreferences.languages"
        case nsfw = "srcPreferences.nsfw"
        case coverQuality = "srcPreferences.coverQuality"
    }
    
    public enum ReaderPreferences: String, UserDefaultsKeys {
        case pageLayout = "readerPreferences.pageLayout"
        case pageQuality = "readerPreferences.pageQuality"
        case mode = "readerPreferences.mode"
    }
    
    public enum Chapters: String, UserDefaultsKeys {
        case order = "chapters.order"
        case downloaded = "chapters.downloaded"
    }
    
    public enum History: String, UserDefaultsKeys {
        case search = "history.search"
    }
}
