//
//  UIStackView+Extension.swift
//  QYOrder
//
//  Created by lihong on 2019/8/4.
//  Copyright © 2019 qy. All rights reserved.
//

import UIKit

extension UIStackView {
    public func removeAllArrangedSubview() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
            view.removeFromSuperview()
        }
    }
}
