//
//  Helper.swift
//  Extension
//
//  Created by lihong on 2019/8/22.
//  Copyright © 2019 lihong. All rights reserved.
//

import Foundation

func synchronized(lock: Any, closure: () -> ()) {
    objc_sync_enter(lock)
    closure()
    objc_sync_exit(lock)
}



