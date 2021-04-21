//
//  UIPageViewController+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/11/1.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit

extension UIPageViewController: UIGestureRecognizerDelegate {
    public func addPanBack() {
        guard let interactivePopGestureRecognizer = navigationController?.interactivePopGestureRecognizer else { return }
        
        let first = view.subviews.first { return $0 is UIScrollView }
        guard let scrollView = first else {
            return
        }
        
        let pan = UIPanGestureRecognizer()
        pan.delegate = self
        scrollView.addGestureRecognizer(pan)
        pan.require(toFail: interactivePopGestureRecognizer)
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let count = navigationController?.viewControllers.count, count > 1 else {
            return false
        }
        
        let translation = gestureRecognizer.location(in: view)
        return translation.x < 30
    }
}
