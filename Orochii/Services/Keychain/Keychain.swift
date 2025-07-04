//
//  Keychain.swift
//  Orochii
//
//  Created by Douglas Henrique de Souza Pereira on 23/05/23.
//

import AuthenticationServices

/// Keychain service credentials identification
public enum KeychainService {
    /// Keychain service *key*
    public enum Key: String {
        case accessToken = "access-token", expiresIn = "expires-in", userId = "user-id"
    }
    
    /// Keychain service *account*
    public enum Account: String {
        case anilist
    }
}

/// Keychain service hanlder
final class Keychain {
    static var standard = Keychain()
    
    /// Save data on keychain
    /// - Parameters:
    ///   - data: data to be saved
    ///   - service: Data related service
    ///   - account: Data related account
    func save(_ data: Data, service: KeychainService.Key, account: KeychainService.Account) throws {
        let query = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue
        ] as [CFString: Any] as CFDictionary
        
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
    func update(_ data: Data, service: KeychainService.Key, account: KeychainService.Account) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as [CFString: Any] as CFDictionary
                
            let updatedData = [kSecValueData: data] as CFDictionary
            SecItemUpdate(query, updatedData)
    }
    
    /// Read data from keychain
    /// - Parameters:
    ///   - service: Data related service
    ///   - account: Data related account
    /// - Returns: Read data
    func read(service: KeychainService.Key, account: KeychainService.Account) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue,
            kSecReturnData: true
        ] as [CFString: Any] as CFDictionary
                
            var result: AnyObject?
            SecItemCopyMatching(query, &result)
            return result as? Data
    }
    
    /// Delete data from keychain
    /// - Parameters:
    ///   - service: Data related service
    ///   - account: Data related account
    func delete(service: KeychainService.Key, account: KeychainService.Account) throws {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service.rawValue,
            kSecAttrAccount: account.rawValue
        ] as [CFString: Any] as CFDictionary
        let status = SecItemDelete(query)
        print(SecCopyErrorMessageString(status, nil).debugDescription)
    }
}
