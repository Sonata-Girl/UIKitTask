// UIColor+extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к кастомным цветам
extension UIColor {
    var appPurple: UIColor? {
        UIColor(named: "AppPurple") ?? nil
    }

    var appPurpleLight: UIColor? {
        UIColor(named: "appPurpleLight") ?? nil
    }

    var appPink: UIColor? {
        UIColor(named: "appPink") ?? nil
    }
}
