//
//  NetworkManager.swift
//  Onboarding
//
//  Created by Kostiantyn Kaniuka on 08.04.2025.
//

import Foundation

protocol HTTPClientProtocol {
    func fetchQuizData(from urlString: String) async throws -> [QuizItem]
}

enum NetworkError: Error {
    case badURL
    case badServerResponse
    case unknownError
}

class NetworkManager: HTTPClientProtocol {
    
    func fetchQuizData(from urlString: String) async throws -> [QuizItem] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.badURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.badServerResponse
        }

        guard let decoded = try? JSONDecoder().decode(QuizResponse.self, from: data) else {
            throw NetworkError.unknownError
        }
        return decoded.items
    }
}
