// NewNotification.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Уведомление
struct NewNotification {
    /// Тип уведомления
    let type: NotificationType
    /// Дата уведомления
    let date: Date
    /// Ник пользователя
    let user: User
    /// Комментарий пользователя
    let userComment: String?
    /// Картинка поста
    let postImage: String?
    /// Подписаны ли вы на пользователя
    var isYouSigned: Bool

    init(
        type: NotificationType,

        date: Date,
        user: User,
        userComment: String? = nil,
        postImage: String? = nil,
        isYouSigned: Bool = false
    ) {
        self.type = type
        self.date = date
        self.user = user
        self.userComment = userComment
        self.postImage = postImage
        self.isYouSigned = isYouSigned
    }
}
