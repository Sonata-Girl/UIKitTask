// WordModel.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// WordModel
struct WordModel {
    var word: String
    var reversedWord: String {
        String(word.reversed())
    }
}
