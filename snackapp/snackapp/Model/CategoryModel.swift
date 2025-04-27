//
//  CategoryModel.swift
//  snackapp
//
//  Created by Shourya Thakur on 4/26/25.
//

import SwiftUI

struct CategoryModel: Identifiable , Hashable {
    var id: UUID = .init()
    var icon: String
    var title: String
}

var categorylist: [CategoryModel] = [
    CategoryModel(icon: "square.grid.2x2", title: "All"),
    CategoryModel(icon: "cup.and.saucer.fill", title: "Choco"),
    CategoryModel(icon: "birthday.cake.fill", title: "Cake"), // iOS 17+ has "waffle"
    CategoryModel(icon: "candybarphone", title: "Toffee"), // use a close alternative if needed
]
    
