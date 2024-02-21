// UIFont+Extension.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Расширение для быстрого доступа к добавленным шрифтам
extension UIFont {
    /// Получение шрифта Verdana полужирный  с размером
    static func setVerdanaBold(withSize: CGFloat) -> UIFont? {
        UIFont(name: "Verdana-Bold", size: withSize)
    }

    /// Получение шрифта Verdana  с размером
    static func setVerdana(withSize: CGFloat) -> UIFont? {
        UIFont(name: "Verdana", size: withSize)
    }

    /// Получение шрифта Verdana  полужирный курсив с размером
    static func setVerdanaBoldItalic(withSize: CGFloat) -> UIFont? {
        UIFont(name: "Verdana-BoldItalic", size: withSize)
    }
}
