//
//  CartManager.swift
//  snackapp
//
//  Created by Shourya Thakur on 4/26/25.
//

import SwiftUI

class CartManager: ObservableObject {
    @Published var products: [Product] = []
    @Published private(set) var total: Int = 0
    
    func addToCart(product: Product) {
        products.append(product)
        total += product.price
    }
    
    func removeFromCart(product: Product) {
        if let index = products.firstIndex(where: { $0.id == product.id }) {
            total -= products[index].price
            products.remove(at: index)
        }
    }
}
