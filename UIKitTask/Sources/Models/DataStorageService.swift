// DataStorageService.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// Тестовые данные,  заглушки
final class DataStorageService {
    // MARK: Constants

    static let shared = DataStorageService()

    // MARK: Private Properties

    private var currentUser: User?
    private var stories: [Story] = []
    private var posts: [Post] = []
    private var recommendations: [User] = []
    private var news: [NewNotification] = []

    // MARK: Initializers

    private init() {
        fillData()
    }

    // MARK: Public Methods

    func getCurrentUser() -> User {
        currentUser ?? User(name: "none", avatarImage: "none")
    }

    func getPosts() -> [Post] {
        posts
    }

    func getStories() -> [Story] {
        stories
    }

    func getRecommendations() -> [User] {
        recommendations
    }

    func getNews() -> [NewNotification] {
        news
    }

    // MARK: Private Methods

    private func fillData() {
        /// Заполнение пользователей
        let userMe = User(name: "Conata", avatarImage: "myAvatar")
        let userLavanda = User(name: "lavanda123", avatarImage: "avatarLavanda")
        let userTur = User(name: "tur_v_dagestan", avatarImage: "avatarTurDagestan")
        let userMary = User(name: "mary_pol", avatarImage: "recommendTwo")
        let userMiho = User(name: "12miho", avatarImage: "avatarMiho")
        let userMarks = User(name: "markS", avatarImage: "avatarNewsMarks")
        let userSvNeit = User(name: "sv_neit", avatarImage: "avatarNewsNeit")

        /// Заполнение текущего пользователя
        currentUser = userMe

        /// Заполнение сторис
        stories.append(Story(user: userMe, isYour: true))
        stories.append(Story(user: userLavanda, isYour: false))
        stories.append(Story(user: userTur, isYour: false))
        stories.append(Story(user: userMary, isYour: false))
        stories.append(Story(user: userLavanda, isYour: false))
        stories.append(Story(user: userMiho, isYour: false))
        stories.append(Story(user: userLavanda, isYour: false))
        stories.append(Story(user: userLavanda, isYour: false))

        /// Заполнение рекоммендаций
        recommendations.append(User(name: "сrimea_082", avatarImage: "recommendOne"))
        recommendations.append(User(name: "mary_pol", avatarImage: "recommendTwo"))
        recommendations.append(userMiho)

        /// Заполнение ленты постов
        let imagesTur: [String] = ["postOne", "postTwo", "postOne", "postTwo"]
        var comment = "Отдохните от РМ и насладитесь красотой природы. Забронировать тур в Дагестан можно уже сейчас!"
        posts.append(Post(user: userTur, images: imagesTur, comment: comment, likes: 201, currentUser: userMe))

        comment = "Забронировать тур в Дагестан можно уже сейчас!"
        posts.append(Post(user: userTur, images: ["postTwo"], comment: comment, likes: 1000, currentUser: userMe))

        comment = "Путешествие в замок на рефлексии! Всем советую, прекрасное место для отдыха от РМ!"
        posts.append(
            Post(user: userLavanda, images: ["recommendOne"], comment: comment, likes: 100_500, currentUser: userMe)
        )

        comment = "Наконец-то выехала на отдых за город и можно немного поспать!"
        posts.append(
            Post(user: userMary, images: ["recommendTwo"], comment: comment, likes: 10000, currentUser: userMe)
        )

        comment = "Ура выходные!"
        posts.append(
            Post(user: userMiho, images: ["avatarMiho"], comment: comment, likes: 100, currentUser: userMe)
        )

        /// Заполнение уведомлений
        comment = "Очень красиво!"
        news.append(NewNotification(
            type: .newLikeOnComment, date: Date(), user: userLavanda,
            userComment: comment, postImage: "imageNewsLavanda"
        ))

        comment = "Спасибо"
        news.append(NewNotification(
            type: .userCallYou, date: Date(),
            user: userLavanda, userComment: comment, postImage: "imageNewsLavanda"
        ))

        comment = "Это где?"
        news.append(NewNotification(
            type: .newLikeOnComment, date: Date() - TimeInterval(60 * 60 * (24 * 2)), user: userLavanda,
            userComment: comment, postImage: "imageNewsLavandaTwo"
        ))

        news.append(NewNotification(
            type: .newUser, date: Date() - TimeInterval(60 * 60 * (24 * 3)),
            user: userMiho
        ))

        news.append(NewNotification(
            type: .newFollower, date: Date() - TimeInterval(60 * 60 * (24 * 4)),
            user: userLavanda, isYouSigned: true
        ))

        comment = "Ты вернулась?"
        news.append(NewNotification(
            type: .newLikeOnComment, date: Date() - TimeInterval(60 * 60 * (24 * 5)), user: userLavanda,
            userComment: comment, postImage: "imageNewsLavandaTwo"
        ))

        comment = "Ты вернулась?"
        news.append(NewNotification(
            type: .newLikeOnComment, date: Date() - TimeInterval(60 * 60 * (24 * 5)), user: userLavanda,
            userComment: comment, postImage: "imageNewsLavandaTwo"
        ))

        news.append(NewNotification(
            type: .newUser, date: Date() - TimeInterval(60 * 60 * (24 * 6)),
            user: userMarks
        ))

        news.append(NewNotification(
            type: .newUser, date: Date() - TimeInterval(60 * 60 * (24 * 6)),
            user: userSvNeit
        ))
    }
}
