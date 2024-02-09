// UIFont+extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

extension UIFont {
    static func setVerdanaBold(withSize: CGFloat) -> UIFont? {
        UIFont(name: "Verdana-Bold", size: withSize)
    }

    static func setVerdanaBoldItalic(withSize: CGFloat) -> UIFont? {
        UIFont(name: "Verdana-BoldItalic", size: withSize)
    }
}
