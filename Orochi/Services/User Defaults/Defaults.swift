//
//  Defaults.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 12/07/23.
//

import Foundation

class Defaults {
    static var standard = Defaults()
    private let defaults = UserDefaults.standard
    
    func saveObj(_ value: Any, key: String) {
        defaults.setValue(value, forKey: key)
    }
    
    func saveInt(_ value: Int, key: String) {
        defaults.setValue(value, forKey: key)
    }
    
    func saveBool(_ value: Bool, key: String) {
        defaults.setValue(value, forKey: key)
    }
    
    func saveArray<Value>(of values: Value, key: String) {
        defaults.setValue(values, forKey: key)
    }
    
    func getObj(of key: String) -> Any? {
        defaults.object(forKey: key)
    }
    
    func getInt(of key: String) -> Int {
        defaults.integer(forKey: key)
    }
    
    func getBool(of key: String) -> Bool {
        defaults.bool(forKey: key)
    }
    
    func getArray(of key: String) -> [Any]? {
        defaults.array(forKey: key)
    }
    
}
