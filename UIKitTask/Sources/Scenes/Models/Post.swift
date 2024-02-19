// Post.swift
// Copyright © RoadMap. All rights reserved.

/// Пост
struct Post {
    /// Пользователь поста
    let user: User
    /// Картинки поста
    let images: [String]
    /// Комментарий поста
    let comment: String
    /// Количество лайков поста
    let likes: Int
}
