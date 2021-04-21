//
//  UIButton+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/7/2.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit

extension UIButton {

    /// title 白色，背景蓝色，字号 18
    public func setTitleWhiteStyle(_ radius: CGFloat = 5, color: UIColor)  {
        assert(buttonType == UIButton.ButtonType.custom, "Button's type must is custom")
        
        setupFont()
        cornerRadius = radius
        setTitleColor(UIColor.white, for: .normal)
        backgroundColor = UIColor.clear
        let size = 2 * radius + 2
        if let image = UIImage.color(color, size: CGSize(width: size, height: size), radius: radius)
            ,let hightImage = UIImage.color(color.withAlphaComponent(0.6), size: CGSize(width: size, height: size), radius: radius){
            setBackgroundImage( image.stretchableImage(withLeftCapWidth: Int(size / 2), topCapHeight: Int(size / 2)), for: .normal)
            setBackgroundImage( hightImage.stretchableImage(withLeftCapWidth: Int(size / 2), topCapHeight: Int(size / 2)), for: .highlighted)
            setBackgroundImage( hightImage.stretchableImage(withLeftCapWidth: Int(size / 2), topCapHeight: Int(size / 2)), for: .disabled)
        } else {
            backgroundColor = color
        }
    }
    
    public func setImage(_ image: UIImage) {
        setImage(image, for: .normal)
        
        guard buttonType == .custom else {
            return
        }
        setImage(image.alpha(0.5), for: .highlighted)
    }

    /// title 蓝色，背景白色，字号 18
    public func setTitleBlueStyle(_ radius: CGFloat = 5, color: UIColor) {
        let hColor = color.withAlphaComponent(0.6)

        setupFont()
        setTitleColor(color, for: .normal)
        setTitleColor(hColor, for: .highlighted)

        if let image = UIImage.radiusLine(color, radius: radius),
            let hImage = UIImage.radiusLine(hColor, radius: radius) {
            setBackgroundImage(image.stretchableImage(withLeftCapWidth: Int(radius + 1), topCapHeight: Int(radius + 1)), for: .normal)
            setBackgroundImage(hImage.stretchableImage(withLeftCapWidth: Int(radius + 1), topCapHeight: Int(radius + 1)), for: .highlighted)
        } else {
            cornerRadius = radius
            layer.borderWidth = 0.5
            layer.borderColor = color.cgColor
            backgroundColor = UIColor.white
        }
    }
    
    /// title
    public func setStyle(_ radius: CGFloat = 5, titleColor: UIColor, backgroundColor: UIColor) {
        setupFont()
        cornerRadius = radius
        setTitleColor(titleColor, for: .normal)
        setTitleColor(titleColor.withAlphaComponent(0.6), for: .highlighted)
        
        let size = 2 * radius + 2
        if let image = UIImage.color(backgroundColor, size: CGSize(width: size, height: size), radius: radius)
            ,let hightImage = UIImage.color(backgroundColor.withAlphaComponent(0.6), size: CGSize(width: size, height: size), radius: radius){
            setBackgroundImage( image.stretchableImage(withLeftCapWidth: Int(size / 2), topCapHeight: Int(size / 2)), for: .normal)
            setBackgroundImage( hightImage.stretchableImage(withLeftCapWidth: Int(size / 2), topCapHeight: Int(size / 2)), for: .highlighted)
        } else {
            self.backgroundColor = backgroundColor
        }

    }
    
    private func setupFont() {
        titleLabel?.font = UIFont.systemFont(ofSize: 17)
    }
    
//    func setImageAttachment(_ string: String, image: UIImage, index: Int? = nil, offset: CGPoint = CGPoint(x: 0, y: 0)) {
//        let font = titleLabel?.font ?? Font.detail.font
//        let color = titleColor(for: .normal) ?? Font.title.color
//        let attriStr = NSAttributedString.imageAttribueString(string, image: image, font: font, color: color, index: index, offset: offset)
//        
//        setAttributedTitle(attriStr, for: .normal)
//    }
}

extension UIButton {
    struct AssociatedObKeys {
        static var textFields = "textFields"
        static var enableBlock = "enableBlock"
    }
    
    private var textFields: [UITextField] {
        set {
            objc_setAssociatedObject(self, &AssociatedObKeys.textFields, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedObKeys.textFields) as? [UITextField]) ?? []
        }
    }
    private var enableBlock: (() -> Bool)? {
        set {
            objc_setAssociatedObject(self, &AssociatedObKeys.enableBlock, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedObKeys.enableBlock) as? (() -> Bool)
        }
    }
    
    public func addEnabledObserver(for textFields:[UITextField], enable: (() -> Bool)? = nil) {
        removeEnabledObserver()
        self.textFields = textFields
        enableBlock = enable
        updateEnabled()
        for textFiled in textFields {
            NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange), name: UITextField.textDidChangeNotification, object: textFiled)
        }
    }
    
    @objc func textFieldDidChange() {
        updateEnabled()
    }
    
    public func updateEnabled() {
        isEnabled = (textFields.filter({ $0.text?.isEmpty != false }).count == 0) && (enableBlock?() ?? true)
    }
    
    public func removeEnabledObserver() {
        guard textFields.count > 0 else {
            return
        }
        
        for textFiled in textFields {
            NotificationCenter.default.removeObserver(textFiled)
        }
        textFields = []
    }
}

extension UIButton {
    public typealias TouchBlockType = (UIButton) -> Void
    static var _touchBlockKey = "_touchBlockKey"
    private var _touchBlock:TouchBlockType? {
        set {
            objc_setAssociatedObject(self, &UIButton._touchBlockKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get {
            return objc_getAssociatedObject(self, &UIButton._touchBlockKey) as? TouchBlockType
        }
    }
    public func setTouchBlock(_ block:@escaping TouchBlockType) {
        _touchBlock = block
        addTarget(self, action: #selector(_ontouchBlock), for: .touchUpInside)
    }
    
    @objc func _ontouchBlock() {
        _touchBlock?(self)
    }
}
