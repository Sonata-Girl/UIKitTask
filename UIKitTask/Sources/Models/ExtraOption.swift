// ExtraOption.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Дополнительная опция продукта (напитка)
struct ExtraOption {
    // Наименование доп. опции
    let name: String
    // Стоимость доп. опции
    let price: Int
    // Признак того, что опция выбрана
    var select: Bool = false
}
