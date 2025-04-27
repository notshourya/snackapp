//
//  ProductModel.swift
//  snackapp
//
//  Created by Shourya Thakur on 4/26/25.
//

import SwiftUI

//Product Model
struct Product: Identifiable {
    var id: UUID = .init()
    var name: String
    var category: String
    var image: String
    var color: Color
    var price: Int
}


// Sample Products
var productList = [
    Product(name: "Choco Chip", category: "Choco", image: "image 1", color: .pink ,price: 40),
    Product(name: "Unreal Muffins", category: "Choco", image: "image 2",color: .yellow, price: 90),
    Product(name: "Twister Chips", category: "Chips", image: "image 3",color: .red, price: 20),
    Product(name: "Taki Chips", category: "Chips", image: "image 4",color: .green, price: 35),
    Product(name: "Regular Nature", category: "Chips", image: "image 5",color: .blue, price: 25),
    Product(name: "Dark Russet", category: "Chips", image: "image 6",color: .brown, price: 50),
    Product(name: "Smith Chips", category: "Chips", image: "image 7",color: .orange,price: 110),
    Product(name: "Deep River", category: "Chips", image: "image 8", color: .purple, price: 90)
]
