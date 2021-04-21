//
//  UIImage+Extension.swift
//  MWallet
//
//  Created by Lihong.zhu on 2018/7/2.
//  Copyright © 2018年 Lihong.zhu. All rights reserved.
//

import UIKit

extension UIImage {
    public static func color(_ color: UIColor, size: CGSize, radius: CGFloat = 0) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale);
        
        let rectanglePath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0, y: 0), size: size), cornerRadius: radius)
        color.setFill()
        rectanglePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    public static func gradientImage(with colors: [UIColor], size: CGSize, start: CGPoint = CGPoint(x: 0, y: 0.5), end: CGPoint = CGPoint(x: 1, y: 0.5), radius: CGFloat = 0) -> UIImage? {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        gradientLayer.startPoint = start
        gradientLayer.endPoint = end
        gradientLayer.colors = colors.map({ $0.cgColor })
        UIGraphicsBeginImageContextWithOptions(size, gradientLayer.isOpaque, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        let rectanglePath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0, y: 0), size: size), cornerRadius: radius)
        rectanglePath.addClip()
        gradientLayer.render(in: context)
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return outputImage
    }
    
    public static func qr(_ qr: String, size: CGFloat) -> UIImage? {
        guard let data = qr.data(using: .utf8)
            ,let filter = CIFilter(name: "CIQRCodeGenerator") else {
            return nil
        }
        filter.setDefaults()
        filter.setValue(data, forKey: "inputMessage")

        guard let outputImage = filter.outputImage else {
            return nil
        }
        let scale = size / outputImage.extent.width
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        let transformImage = outputImage.transformed(by: transform)
        let context = CIContext(options: nil)
        guard let imageRef = context.createCGImage(transformImage, from: transformImage.extent) else {
            return nil
        }
        let qrCodeImage = UIImage(cgImage: imageRef)
        
        return qrCodeImage
    }
    
    public func alpha(_ alpha: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale);
        guard let ctx = UIGraphicsGetCurrentContext()
            ,let cgImage = self.cgImage else {
            return nil
        }
        let area = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        
        ctx.ctm.scaledBy(x: 1, y: -1)
        ctx.ctm.translatedBy(x: 0, y: -area.size.height)
        ctx.setBlendMode(.multiply)
        ctx.setAlpha(alpha)
        ctx.draw(cgImage, in: area)
        let newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return newImage;
    }
    
    public func resize(_ size: CGSize, scale: CGFloat? = nil) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale ?? UIScreen.main.scale)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
    public func recolor(_ color: UIColor) -> UIImage?
    {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        guard let context = UIGraphicsGetCurrentContext(), let cgImage = cgImage else {
            return nil
        }
        
        context.translateBy(x: 0, y: size.height)
        context.scaleBy(x: 1, y: -1)
        context.setBlendMode(.normal)
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        context.clip(to: rect, mask: cgImage)
        color.setFill()
        context.fill(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage;
    }

    public static func radiusLine(_ color: UIColor, size: CGSize? = nil, lineWidth: CGFloat = 0.5, radius: CGFloat = 5) -> UIImage? {
        let size = size ?? CGSize(width: radius * 2 + 2, height: radius * 2 + 2)
        UIGraphicsBeginImageContextWithOptions(size, false, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: CGRect(x: lineWidth / 2, y: lineWidth / 2, width: size.width - lineWidth, height: size.height - lineWidth), cornerRadius: radius)
        context?.setLineWidth(lineWidth)
        context?.setStrokeColor(color.cgColor)
        context?.addPath(path.cgPath)
        context?.strokePath()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
    
    public static func avatar(_ name: String, textColor: UIColor, bgColor: UIColor, size: CGFloat) -> UIImage? {
        let string = name.substring(from: 0, length: 2) ?? name
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: size, height: size), false, UIScreen.main.scale);
        let rectanglePath = UIBezierPath(roundedRect: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: size, height: size)), cornerRadius: size / 2)
        bgColor.setFill()
        rectanglePath.fill()
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = .center
        let font = UIFont.systemFont(ofSize: size / 3)
        let attributed = NSAttributedString(string: string, attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.foregroundColor: textColor])
        let strSize = attributed.size()
        attributed.draw(at: CGPoint(x: (size - strSize.width) / 2, y: (size - strSize.height) / 2))
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return image;
    }
    
    public func cropping(to: CGRect) -> UIImage? {
        guard let cgImage = self.cgImage,
              let croppedImage = cgImage.cropping(to: to) else {
            return nil
        }
                
        return UIImage(cgImage: croppedImage)
    }

}


extension UIImage {
    public func rotateToLeft() -> UIImage? {
        guard let cgImage = cgImage else {
            return nil
        }
        
        var newOrientation = UIImage.Orientation.up
        switch imageOrientation {
        case .up:
            newOrientation = .left
                break;
        case .left:
            newOrientation = .down
                break;
        case .down:
            newOrientation = .right
                break;
        case .right:
            newOrientation = .up
                break;
        case .upMirrored:
            newOrientation = .leftMirrored;
                break;
        case .downMirrored:
            newOrientation = .rightMirrored
                break;
        case .leftMirrored:
            newOrientation = .downMirrored
                break;
        case .rightMirrored:
            newOrientation = .upMirrored
                break;
        @unknown default:
            return nil
        }
        
        return UIImage(cgImage: cgImage, scale: 1, orientation: newOrientation)
    }

    public func rotateToRight() -> UIImage? {
        guard let cgImage = cgImage else {
            return nil
        }
        
        var newOrientation = UIImage.Orientation.up
        switch imageOrientation {
        case .up:
            newOrientation = .right
                break;
        case .left:
            newOrientation = .up
                break;
        case .down:
            newOrientation = .left
                break;
        case .right:
            newOrientation = .down
                break;
        case .upMirrored:
            newOrientation = .rightMirrored
                break;
        case .downMirrored:
            newOrientation = .leftMirrored
                break;
        case .leftMirrored:
            newOrientation = .upMirrored
                break;
        case .rightMirrored:
            newOrientation = .downMirrored
                break;
        @unknown default:
            return nil
        }
        
        return UIImage(cgImage: cgImage, scale: 1, orientation: newOrientation)
    }

}

public extension UIImage {
    func hexString() -> String? {
        return pngData()?.hexString
    }
}


public extension UIImage {
    static let filterNameList = [
        "No Filter",
        "CIPhotoEffectChrome",
        "CIPhotoEffectFade",
        "CIPhotoEffectInstant",
        "CIPhotoEffectMono",
        "CIPhotoEffectNoir",
        "CIPhotoEffectProcess",
        "CIPhotoEffectTonal",
        "CIPhotoEffectTransfer",
        "CILinearToSRGBToneCurve",
        "CISRGBToneCurveToLinear"
    ]

    static let filterDisplayNameList = [
        "Normal",
        "Chrome",
        "Fade",
        "Instant",
        "Mono",
        "Noir",
        "Process",
        "Tonal",
        "Transfer",
        "Tone",
        "Linear"
    ]

    func createFilteredImage(filterName: String) -> UIImage {
        let context = CIContext(options: nil)
        // 1 - create source image
        let sourceImage = CIImage(image: self)

        // 2 - create filter using name
        guard let filter = CIFilter(name: filterName) else {
            return self
        }
        filter.setDefaults()

        // 3 - set source image
        filter.setValue(sourceImage, forKey: kCIInputImageKey)

        // 4 - output filtered image as cgImage with dimension.
        guard let outputImage = filter.outputImage,
              let outputCGImage = context.createCGImage(outputImage, from: outputImage.extent) else {
            return self
        }
        
        // 5 - convert filtered CGImage to UIImage
        let filteredImage = UIImage(cgImage: outputCGImage)

        return filteredImage
    }
}
