// UIColor+Extensions.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к добавленным цветам
extension UIColor {
    static func appPinkColor() -> UIColor? {
        UIColor(red: 225 / 255, green: 24 / 255, blue: 131 / 255, alpha: 1)
    }

    static func appBackgroundViewColor() -> UIColor? {
        UIColor(red: 248 / 255, green: 248 / 255, blue: 248 / 255, alpha: 1)
    }

    static func appBackgroundLineViewColor() -> UIColor? {
        UIColor(red: 236 / 255, green: 235 / 255, blue: 235 / 255, alpha: 1)
    }
}
