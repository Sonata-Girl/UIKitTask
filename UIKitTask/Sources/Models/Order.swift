// Order.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель заказа гостя
struct Order {
    let product: Coffee
    var additions: [ExtraOption]

    mutating func addOption(addition: ExtraOption) {
        additions.append(addition)
    }
}
