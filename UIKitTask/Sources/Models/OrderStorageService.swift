// OrderStorageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель заказа гостя
struct OrderStorageService {
    // MARK: Private Properties

    /// Тип продукта, тип кофе
    private(set) var product: Coffee
    /// Дополнительные опции напитка или заказа
    private(set) var additions: [ExtraOption] = []
    /// Тип обжарки напитка
    private(set) var roasting: RoastingType
    /// Цена напитка суммарно с доп. опциями
    private(set) var price = 0
    /// Все доступные опции
    private var defaultAdditions: [ExtraOption] {
        [
            ExtraOption(name: "Молоко", price: 50),
            ExtraOption(name: "Сироп", price: 20),
            ExtraOption(name: "Молоко соевое", price: 50),
            ExtraOption(name: "Молоко миндальное", price: 70),
            ExtraOption(name: "Эспрессо", price: 50)
        ]
    }

    // MARK: Initializers

    init(product: Coffee, roasting: RoastingType) {
        self.product = product
        self.roasting = roasting
        additions = defaultAdditions
        calculatePrice()
    }

    // MARK: Public Methods

    /// Изменение продукта/напитка в заказе
    mutating func changeProduct(product: Coffee) {
        self.product = product
        calculatePrice()
    }

    /// Изменение доп. опций в заказе
    mutating func changeOptions(options: [ExtraOption]) {
        additions = options
        calculatePrice()
    }

    /// Изменение типа обжарки в заказе
    mutating func changeRoasting(roastingType: RoastingType) {
        roasting = roastingType
    }

    // MARK: Private Methods

    /// Пересчет цены заказа
    private mutating func calculatePrice() {
        price = additions.filter(\.select).map(\.price).reduce(0, +) + product.price
    }
}
