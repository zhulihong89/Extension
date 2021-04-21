//
//  UUID+Device.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/9/6.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import Foundation

extension UUID {
    
    public static var device: String {
        let key = "udid"
        
        if let uuid = UserDefaults.standard.object(forKey: key) as? String {
            return uuid
        }
        if let uuid = KeyChainHandler.load(key) as? String {
            return uuid
        }
        let uuid = UUID().uuidString
        UserDefaults.standard.set(uuid, forKey: key)
        KeyChainHandler.save(key, data: uuid)
        
        return uuid
    }
    
}
