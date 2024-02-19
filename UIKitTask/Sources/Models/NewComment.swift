// NewComment.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Тип уведомления
enum NotificationType {
    case newComment
    case newUser
    case newFollower
}

/// Уведомление
struct NewNotification {
    /// Тип уведомления
    let type: NotificationType
    /// Дата уведомления
    let date: Date
    /// Ник пользователя
    let userName: String
    /// Аватар пользователя
    let userAvatar: String
    /// Комментарий пользователя
    let userCcomment: String?
    /// Картинка поста
    let postImage: String?
    /// Подписаны ли вы на пользователя
    let isYouSigned: Bool?
}
