//
//  UIViewExtension.swift
//  AdoCao
//
//  Created by André N. dos Santos on 30/06/22.
//

import Foundation
import UIKit

extension UIView {
    func roundCorners(cornerRadius: CGFloat, cornerType: CACornerMask) {
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = cornerType
        self.clipsToBounds = true
    }
    
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


    func addShadow(shadowColor: CGColor = UIColor.black.cgColor,
               shadowOffset: CGSize = CGSize(width: 2.0, height: 4.0),
               shadowOpacity: Float = 0.6,
               shadowRadius: CGFloat = 5.0) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
}

extension CACornerMask {
    static public let inferiorDireito: CACornerMask = .layerMaxXMaxYCorner
    static public let inferiorEsquerdo: CACornerMask = .layerMinXMaxYCorner
    static public let superiorDireito: CACornerMask = .layerMaxXMinYCorner
    static public let superiorEsquerdo: CACornerMask = .layerMinXMinYCorner
}
