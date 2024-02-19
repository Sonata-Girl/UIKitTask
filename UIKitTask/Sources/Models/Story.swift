// Story.swift
// Copyright © RoadMap. All rights reserved.

/// Сторис
struct Story {
    /// Пользователь, чей сторис
    let user: User
    /// Новый сторис (просмотренный или нет)
    let isNew: Bool
    /// Это ваша история
    let isYour: Bool

    init(user: User, isYour: Bool) {
        self.user = user
        isNew = !isYour
        self.isYour = isYour
    }
}
