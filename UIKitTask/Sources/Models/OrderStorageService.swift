// OrderStorageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель заказа гостя
struct OrderStorageService {

    // MARK: Private Properties

    private(set) var product: Coffee
    private(set) var additions: [ExtraOption] = []
    private(set) var roasting: RoastingType
    private(set) var price = 0

    // MARK: Initializers

    init(product: Coffee, roasting: RoastingType) {
        self.product = product
        self.roasting = roasting
        additions = fillAdditions()
    }

    // MARK: Public Methods
   
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


    // MARK: Private Methods

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
