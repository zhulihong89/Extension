//
//  UITableView+Extension.swift
//  Extension
//
//  Created by lihong on 2020/3/7.
//  Copyright © 2020 lihong. All rights reserved.
//

import UIKit

extension UITableView {

    public func registerNib(name: String) {
        register(UINib(nibName: name, bundle: Bundle.main), forCellReuseIdentifier: name)
    }

    public func disableSelfSizing() {
        estimatedRowHeight = 0
        estimatedSectionFooterHeight = 0
        estimatedSectionHeaderHeight = 0
    }
}

