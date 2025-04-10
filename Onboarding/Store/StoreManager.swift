//
//  StoreManager.swift
//  Onboarding
//
//  Created by Kostiantyn Kaniuka on 10.04.2025.
//

import Foundation
import StoreKit

@MainActor
final class StoreManager {
    private let productId = ["com.premiumsub.id"]
    
     private(set) var products: [Product] = []
     private var productsLoaded = false
     private var updates: Task<Void, Never>? = nil
    
     private(set) var purchasedProductIDs = Set<String>()

       var hasUnlockedPro: Bool {
          return !self.purchasedProductIDs.isEmpty
       }
    
    
    
    
    init() {
        Task {
            do {
                try await loadProducts()
            } catch {
                print("Failed to load products: \(error.localizedDescription)")
            }
            
        }
        updates = observeTransactionUpdates()
    }
    
    deinit {
        updates?.cancel()
    }
    
    func updatePurchasedProducts() async {
           for await result in Transaction.currentEntitlements {
               guard case .verified(let transaction) = result else {
                   continue
               }

               if transaction.revocationDate == nil {
                   self.purchasedProductIDs.insert(transaction.productID)
               } else {
                   self.purchasedProductIDs.remove(transaction.productID)
               }
           }
       }
    
    private func observeTransactionUpdates() -> Task<Void, Never> {
            Task(priority: .background) { [unowned self] in
                for await _ in Transaction.updates {
                    await self.updatePurchasedProducts()
                }
            }
        }
    
    private func loadProducts() async throws {
           guard !self.productsLoaded else { return }
           self.products = try await Product.products(for: productId)
           self.productsLoaded = true
       }
    
    func purchase(_ product: Product) async throws {
        let result = try await product.purchase()
        
        switch result {
        case let .success(.verified(transaction)):
            print("success transaction: \(transaction)")
            await self.updatePurchasedProducts()
            await transaction.finish()
        case let .success(.unverified(_, error)):
            print("success payed but unverified", error)
            break
        case .pending:
            print("awaiting for approval")
            break
        case .userCancelled:
            print("cancelled")
            break
        @unknown default:
            break
        }
    }
    
    
    
}
