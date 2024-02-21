// NotificationType.swift
// Copyright © RoadMap. All rights reserved.

/// Тип уведомления
enum NotificationType {
    /// Уведомление о новом лайке на комментарии
    case newLikeOnComment
    /// Уведомление о появлении нового пользователя
    case newUser
    /// Уведомление о новом подписчике
    case newFollower
    /// Уведомление о том, что кто-то вас упомянул
    case userCallYou

    /// Текст сообщения для каждого типа
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
