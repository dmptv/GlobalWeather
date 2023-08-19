//
//  AppInteractor.swift
//  GlobalWeather
//
//  Created by Kanat on 30.07.2023.
//

import Foundation

protocol AppInteractorInputProtocol {
    func start(_ completion: EmptyBlock)
    func performLogout()
    func loginWith(firtsName: String, progressBlock: BlockObject<AnyObject, Void>)
}

class AppInteractor: AppInteractorInputProtocol {
    typealias ServiceLocatorAlias = UserServiceLocatorProtocol &
    UserDefaultsServiceLocator & DatabaseServiceLocatorProtocol
    
    final class ServiceLocator: ServiceLocatorAlias {}
    
    private var userService: UserServiceProtocol
    private let userDefaults: UserDefaultsProtocol
    private let databaseService: DatabaseServiceProtocol
    
    init(serviceLocator: ServiceLocatorAlias = ServiceLocator()) {
        userService = serviceLocator.userService()
        userDefaults = serviceLocator.userDefaults()
        databaseService = serviceLocator.serviceDatabase()
    }
    
    func start(_ completion: EmptyBlock) {
        databaseService.setup(version: setRealmNumber(), key: getKey())
    }
    
    
    func performLogout() {
        userService.removeAll()
        removeUserDefaultsObjects()
        deleteCookies()
    }
    
    func deleteCookies() {
        let cookieStorage = HTTPCookieStorage.shared
        cookieStorage.cookies?.forEach {
            cookieStorage.deleteCookie($0)
        }
    }
    
    func removeUserDefaultsObjects() {
        userDefaults.removeObject(forKey: "")
    }
    
    func loginWith(firtsName: String, progressBlock: BlockObject<AnyObject, Void>) {
        
    }
    
}

extension AppInteractor {
    private func getKey() -> Data {
        /// Identifier for our keychain - must be unique across applications.
        let keychainIdentifier = "com.globalWeather.Realm.EncryptionKey"
        let keychainIdentifierData = keychainIdentifier.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        /// Check keychain for an existing key
        var query: [NSString: AnyObject] = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecReturnData: true as AnyObject
        ]
        
        var dataTypeRef: AnyObject?
        var status = withUnsafeMutablePointer(to: &dataTypeRef) { SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0)) }
        if status == errSecSuccess {
            return dataTypeRef as? Data ?? Data()
        }
        
        // Generate a random encryption key
        var key = Data(count: 64)
        key.withUnsafeMutableBytes({ (pointer: UnsafeMutableRawBufferPointer) in
            guard let baseAddress = pointer.baseAddress else {
                print("🚩🚩🚩 there is no baseAddress at \(#file) and \(#function)")
                return
            }
            let result = SecRandomCopyBytes(kSecRandomDefault, 64, baseAddress)
            assert(result == 0, "Failed to get random bytes")
        })
        
        /// Store key in keychain
        query = [
            kSecClass: kSecClassKey,
            kSecAttrApplicationTag: keychainIdentifierData as AnyObject,
            kSecAttrKeySizeInBits: 512 as AnyObject,
            kSecValueData: key as AnyObject
        ]
        status = SecItemAdd(query as CFDictionary, nil)
        assert(status == errSecSuccess, "Failed to insert the new key in the keychain")
        
        return key
    }

    
    private func setRealmNumber() -> UInt64 {
        guard let dictionary = Bundle.main.infoDictionary,
              let version = dictionary["CFBundleShortVersionString"] as? String,
              let build = dictionary["CFBundleVersion"] as? String,
              let buildTrimmed = Int(build.trimmingCharacters(in: .whitespacesAndNewlines)) else {
            return 1
        }
        
        let resultVersion = version.replacingOccurrences(of: ".", with: "")
        let resultBuild = String(format: "%03d", buildTrimmed)
        return NSDecimalNumber(string: resultVersion + resultBuild).uint64Value
    }
}



