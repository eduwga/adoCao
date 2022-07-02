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
}

extension CACornerMask {
    static public let inferiorDireito: CACornerMask = .layerMaxXMaxYCorner
    static public let inferiorEsquerdo: CACornerMask = .layerMinXMaxYCorner
    static public let superiorDireito: CACornerMask = .layerMaxXMinYCorner
    static public let superiorEsquerdo: CACornerMask = .layerMinXMinYCorner
}
