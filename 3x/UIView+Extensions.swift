//
//  UIView+Extensions.swift
//  3x
//
//  Created by Jeevan Eashwar on 07/06/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import UIKit
extension UIView {

    func dropShadow(scale: Bool = true, shadowOffsetHeight: CGFloat = 2.0) {

        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: shadowOffsetHeight)
        layer.shadowRadius = 2.5
    }

    func dropShadow(scale: Bool = true, opacity: Float = 0.4, radius: CGFloat = 3, offset: CGSize = CGSize.zero) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    enum ViewSide {
        case left, right, top, bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .left:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
        case .top:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
        }

        layer.addSublayer(border)
    }

    func rotate(_ toValue: CGFloat, duration: CFTimeInterval = 0.2) {

        let animation = CABasicAnimation(keyPath: "transform.rotation")

        animation.toValue = toValue
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards

        self.layer.add(animation, forKey: nil)
    }

    func isVisibleInSuperView() -> Bool {
        if self.isHidden || self.superview == nil {
            return false
        }
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController,
            let rootView = rootViewController.view {
            let viewFrame = self.convert(self.bounds, to: rootView)
            let topSafeArea: CGFloat
            let bottomSafeArea: CGFloat
            if #available(iOS 11.0, *) {
                topSafeArea = rootView.safeAreaInsets.top
                bottomSafeArea = rootView.safeAreaInsets.bottom
            } else {
                topSafeArea = rootViewController.topLayoutGuide.length
                bottomSafeArea = rootViewController.bottomLayoutGuide.length
            }
            return viewFrame.minX >= 0 &&
                viewFrame.maxX <= rootView.bounds.width &&
                viewFrame.minY >= topSafeArea &&
                viewFrame.maxY <= rootView.bounds.height - bottomSafeArea
        }
        return false
    }
    
    
}
extension UIView {

    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue

            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    @IBInspectable
    var borderWidth: CGFloat {
      get {
        return layer.borderWidth
      }
      set {
        layer.borderWidth = newValue
      }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
      get {
        if let color = layer.borderColor {
          return UIColor(cgColor: color)
        }
        return nil
      }
      set {
        if let color = newValue {
          layer.borderColor = color.cgColor
        } else {
          layer.borderColor = nil
        }
      }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
      get {
        return layer.shadowRadius
      }
      set {
        layer.shadowRadius = newValue
      }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
      get {
        return layer.shadowOpacity
      }
      set {
        layer.shadowOpacity = newValue
      }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
      get {
        return layer.shadowOffset
      }
      set {
        layer.shadowOffset = newValue
      }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
      get {
        if let color = layer.shadowColor {
          return UIColor(cgColor: color)
        }
        return nil
      }
      set {
        if let color = newValue {
          layer.shadowColor = color.cgColor
        } else {
          layer.shadowColor = nil
        }
      }
    }

    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
               shadowOffset: CGSize = CGSize(width: 1.0, height: 2.0),
               shadowOpacity: Float = 0.4,
               shadowRadius: CGFloat = 3.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}
