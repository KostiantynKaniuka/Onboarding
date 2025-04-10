//
//  QuizModel.swift
//  Onboarding
//
//  Created by Kostiantyn Kaniuka on 06.04.2025.
//

import Foundation

struct QuizResponse: Decodable {
    let items: [QuizItem]
}

struct QuizItem: Decodable, Identifiable {
    let id: Int
    let question: String
    let answers: [String]
}
