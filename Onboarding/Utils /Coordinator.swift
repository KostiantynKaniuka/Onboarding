//
//  Coordinator.swift
//  Onboarding
//
//  Created by Kostiantyn Kaniuka on 16.04.2025.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
    func start()
}

class RootCoordinator: Coordinator {
    private let storeManager = StoreManager()
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(childCoordinators: [RootCoordinator] = [RootCoordinator](), navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let netWorkManager = NetworkManager()
        let quizViewModel = QuizViewModel(networkManager: netWorkManager)
        let quizViewController = QuizViewController(coordinator: self, quizViewModel: quizViewModel)
        
        navigationController.pushViewController(quizViewController, animated: false)
    }
    
  func moveToSubscription() {
      let subscriptionVc = SubscriptionViewController(storeManager: self.storeManager, coordinator: self)
    
        navigationController.setNavigationBarHidden(false, animated: false)
        navigationController.pushViewController(subscriptionVc, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
