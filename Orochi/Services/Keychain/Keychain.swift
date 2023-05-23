//
//  Keychain.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/05/23.
//

import AuthenticationServices

/// Keychain handler
final class Keychain {
    static var standard = Keychain()
    
    /// Save data on keychain
    /// - Parameters:
    ///   - data: data to be saved
    ///   - service: Data related service
    ///   - account: Data related account
    func save(_ data: Data, service: String, account: String) throws {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as [CFString : Any] as CFDictionary
        
        let status = SecItemAdd(query, nil)
        
        if status != errSecSuccess {
            print(SecCopyErrorMessageString(status, nil).debugDescription)
        }
        
        if status == errSecDuplicateItem {
            update(data, service: service, account: account)
        }
    }
    
    /// Update data on keychain
    /// - Parameters:
    ///   - data: data to be updated
    ///   - service: Data related service
    ///   - account: Data related account
    func update(_ data: Data, service: String, account: String) {
        let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account
        ] as [CFString : Any] as CFDictionary
                
            let updatedData = [kSecValueData: data] as CFDictionary
            SecItemUpdate(query, updatedData)
    }
    
    /// Read data from keychain
    /// - Parameters:
    ///   - service: Data related service
    ///   - account: Data related account
    /// - Returns: Read data
    func read(service: String, account: String) -> Data? {
        let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account,
                kSecReturnData: true
        ] as [CFString : Any] as CFDictionary
                
            var result: AnyObject?
            SecItemCopyMatching(query, &result)
            return result as? Data
    }
    
    /// Delete data from keychain
    /// - Parameters:
    ///   - service: Data related service
    ///   - account: Data related account
    func delete(service: String, account: String) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as [CFString : Any] as CFDictionary
        let status = SecItemDelete(query)
        print(SecCopyErrorMessageString(status, nil).debugDescription)
    }
}
