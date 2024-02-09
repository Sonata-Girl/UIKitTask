// GuestModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Описание модели для сохранения информация о госте
struct Guest {
    let login: String
    let FIO: String
    let upfrontPayment: Bool
    let reserved: Bool
}
