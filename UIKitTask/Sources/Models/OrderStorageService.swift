// OrderStorageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Модель заказа гостя
struct OrderStorageService {
    let product: Coffee
    var additions: [ExtraOption]
    var roasting: RoastingType

    mutating func changeOptions(additions: [ExtraOption]) {
        self.additions = additions
    }

    mutating func changeRoasting(roastingType: RoastingType) {
        roasting = roastingType
    }
}
