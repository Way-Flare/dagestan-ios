//
//  KeychainService.swift
//  DagestanTrails
//
//  Created by Рассказов Глеб on 21.07.2024.
//  Copyright © 2024 WayFlare.com. All rights reserved.
//

import Foundation
import Security

public class KeychainService: IKeychainService {
    public init() {}
    
    public static func save(key: String, data: Data) -> OSStatus {
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ] as [String: Any]

        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }

    public static func load(key: String) -> Data? {
        guard let isAuthed = UserDefaults.standard.value(forKey: "isAuthorized") as? Bool,
              isAuthed else {
            delete(key: key)
            return nil
        }
        let query = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrAccount as String: key,
            kSecReturnData as String: kCFBooleanTrue as Any,
            kSecMatchLimit as String: kSecMatchLimitOne
        ] as [String: Any]

        var dataTypeRef: AnyObject?
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        if status == noErr, let data = dataTypeRef as? Data {
            return data
        } else {
            return nil
        }
    }
    
    public static func handleToken(access: String, refresh: String) {
        if let accessData = access.data(using: .utf8),
           let refreshData = refresh.data(using: .utf8) {
            let accessStatus = save(key: ConstantAccess.accessTokenKey, data: accessData)
            let refreshStatus = save(key: ConstantAccess.refreshTokenKey, data: refreshData)

            if accessStatus == noErr {
                print("Access token saved")
                UserDefaults.standard.setValue(true, forKey: "isAuthorized")
            } else {
                print("Access token not saved")
            }

            if refreshStatus == noErr {
                print("Refresh token saved")
            } else {
                print("Refresh token not saved")
            }
        }
    }
    
    private static func delete(key: String) {
          let query = [
              kSecClass as String: kSecClassGenericPassword as String,
              kSecAttrAccount as String: key
          ] as [String : Any]
          
          SecItemDelete(query as CFDictionary)
      }
}
