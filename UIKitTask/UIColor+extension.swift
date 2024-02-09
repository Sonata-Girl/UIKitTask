// UIColor+extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Расширение для доступа к кастомному цвету
extension UIColor {
    static func getRgbColor(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
        UIColor(
            red: red / 255,
            green: green / 255,
            blue: blue / 255,
            alpha: 1
        )
    }
}
