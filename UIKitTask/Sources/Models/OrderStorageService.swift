// OrderStorageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель заказа гостя
struct OrderStorageService {
    private(set) var product: Coffee
    private(set) var additions: [ExtraOption] = []
    private(set) var roasting: RoastingType
    private(set) var price = 0

    mutating func changeProduct(product: Coffee) {
        self.product = product
        calculatePrice()
    }

    mutating func changeOptions(options: [ExtraOption]) {
        additions = options
        calculatePrice()
    }

    mutating func changeRoasting(roastingType: RoastingType) {
        roasting = roastingType
    }

    init(product: Coffee, roasting: RoastingType) {
        self.product = product
        self.roasting = roasting
        additions = fillAdditions()
    }

    private mutating func calculatePrice() {
        price = additions.filter(\.select).map(\.price).reduce(0, +) + product.price
    }

    private func fillAdditions() -> [ExtraOption] {
        [
            ExtraOption(name: "Молоко", price: 50),
            ExtraOption(name: "Сироп", price: 20),
            ExtraOption(name: "Молоко соевое", price: 50),
            ExtraOption(name: "Молоко миндальное", price: 70),
            ExtraOption(name: "Эспрессо", price: 50)
        ]
    }
}
