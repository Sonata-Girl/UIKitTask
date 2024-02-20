// NewNotification.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Тип уведомления
enum NotificationType {
    case newLikeOnComment
    case newUser
    case newFollower
    case userCallYou

    var mainTextComment: String {
        switch self {
        case .newFollower:
            return " подписался(-ась) на ваши новости "
        case .newLikeOnComment:
            return " понравился ваш комментарий: "
        case .newUser:
            return " появился(-ась) в RMLink. Вы можете быть знакомы. "
        case .userCallYou:
            return " упомянул(-а) вас в комментарии: "
        }
    }
}

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
    let isYouSigned: Bool

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
