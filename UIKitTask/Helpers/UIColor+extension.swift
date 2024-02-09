// UIColor+extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для кастомного цвета
extension UIColor {
    /// Получение кастомного зеленого
    static func getRgbColor(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat = 1) -> UIColor {
        UIColor(
            red: red / 255,
            green: green / 255,
            blue: blue / 255,
            alpha: 1
        )
    }
}
