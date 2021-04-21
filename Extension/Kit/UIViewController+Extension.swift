//
//  UIViewController+Extension.swift
//  Extension
//
//  Created by lihong on 2020/6/17.
//  Copyright © 2020 lihong. All rights reserved.
//

import UIKit

extension UIViewController {
    public var visiableViewController: UIViewController {
        guard let presentedViewController = presentedViewController else {
            return self
        }
        
        return presentedViewController.visiableViewController
    }
    
}
