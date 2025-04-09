//
//  QuizViewModel.swift
//  Onboarding
//
//  Created by Kostiantyn Kaniuka on 08.04.2025.
//

import Foundation
import Combine

enum OnboardingStage {
    case occupation
    case age
    case final
    
    var next: OnboardingStage {
        switch self {
        case .occupation: return .age
        case .age: return .final
        case .final: return .occupation // back to first screen if close sail screen
        }
    }
}

final class QuizViewModel {
    private var networkManager: HTTPClientProtocol
    private var quizItems: [QuizItem] = []
    private(set) var quizItem = CurrentValueSubject<QuizItem, Never>(QuizItem(id: 0, question: "", answers: []))
    
    var isButtonEnabled = CurrentValueSubject<Bool, Never>(false)
    var onboardingStage: OnboardingStage = .occupation {
        didSet {
            guideTheUser()
        }
    }
    
    init(networkManager: HTTPClientProtocol) {
        self.networkManager = networkManager
        fetchQuizData()
    }
    
    private func fetchQuizData() {
        Task {
            do {
                quizItems = try await networkManager.fetchQuizData(from: "https://test-ios.universeapps.limited/onboarding")
                guideTheUser()
            }
            catch NetworkError.badURL {
                print("Error: Bad URL")
            } catch NetworkError.badServerResponse {
                print("Error: Bad Server Response")
            } catch NetworkError.unknownError {
                print("Error: Unknown Error")
            } catch {
                print("Unexpected error: \(error)")
                
            }
        }
    }
    
    func guideTheUser() {
        switch onboardingStage {
        case .occupation:
            quizItem.value = quizItems.first { $0.id == 1 } ?? QuizItem(id: 0, question: "", answers: [])
        case .age:
            quizItem.value = quizItems.first { $0.id == 2 } ?? QuizItem(id: 0, question: "", answers: [])
        case .final:
            quizItem.value = quizItems.first { $0.id == 3 } ?? QuizItem(id: 0, question: "", answers: [])
        }
    }
}
