// UIFont+Extensions.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к добавленным шрифтам
extension UIFont {
    static func setVerdanaBold(withSize: CGFloat) -> UIFont? {
        UIFont(name: "Verdana-Bold", size: withSize)
    }

    static func setVerdana(withSize: CGFloat) -> UIFont? {
        UIFont(name: "Verdana", size: withSize)
    }

    static func setVerdanaBoldItalic(withSize: CGFloat) -> UIFont? {
        UIFont(name: "Verdana-BoldItalic", size: withSize)
    }
}
