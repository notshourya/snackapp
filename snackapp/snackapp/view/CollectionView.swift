//
//  CollectionView.swift
//  snackapp
//
//  Created by Shourya Thakur on 4/26/25.
//

import SwiftUI

struct CollectionView: View{
    
    @EnvironmentObject var cartManager: CartManager
    
    @Environment(\.presentationMode) var mode
        
    var body: some View{
        NavigationView {
            ScrollView{
                VStack{
                    HStack {
                        Text("Collection")
                            .font(.system(size: 50))
                            .fontWeight(.bold)
                        
                    }
                    .padding(1)
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(productList, id: \.id) { item in
                            SmallProductCard(product: item)
                                .environmentObject(cartManager)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 10)
                }
            }
        }
    }
}

#Preview {
    CollectionView()
        .environmentObject(CartManager())
}


import SwiftUI

struct SmallProductCard: View {
    
    var product: Product
    @EnvironmentObject var cartManager: CartManager
    @State private var isAdded = false
    
    var body: some View {
        ZStack {
            // Product Image with scaling and rotation effects
            Image(product.image)
                .resizable()
                .scaledToFill()
                .frame(height: 160)
                .padding(.trailing, -50)
                .rotationEffect(Angle(degrees: 20))
                .shadow(radius: 15)
                .offset(y: 10)
                .scaleEffect(isAdded ? 1.1 : 1)
                .animation(.easeInOut(duration: 0.3), value: isAdded)
            
            VStack(alignment: .leading, spacing: 10) {
                // Product Name
                Text(product.name)
                    .font(.system(size: 18, weight: .bold))
                    .lineLimit(1)
                    .foregroundColor(.black)
                    .padding(.horizontal, 8)
                    .padding(.top, 8)
                
                // Category Tag
                Text(product.category)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.black.opacity(0.6))
                    .clipShape(Capsule())
                    .shadow(radius: 3)
                    .padding(.top, 2)
                
                Spacer()
                
                HStack {
                    // Product Price
                    Text("₹\(product.price)")
                        .font(.subheadline)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.black)
                        .clipShape(Capsule())
                        .shadow(radius: 5)
                    
                    Spacer()
                    
                    HStack(spacing: 8) {
                        // Add to Cart Button
                        Button(action: {
                            cartManager.addToCart(product: product)
                            isAdded = true
                        }) {
                            Image(systemName: "cart.badge.plus")
                                .imageScale(.medium)
                                .frame(width: 36, height: 36)
                                .background(Color.black)
                                .foregroundColor(.green)
                                .clipShape(Circle())
                                .shadow(radius: 3)
                                .scaleEffect(isAdded ? 1.2 : 1)
                                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: isAdded)
                        }
                        
                        // Remove from Cart Button
                        if cartManager.products.contains(where: { $0.id == product.id }) {
                            Button(action: {
                                cartManager.removeFromCart(product: product)
                                isAdded = false
                            }) {
                                Image(systemName: "cart.badge.minus")
                                    .imageScale(.medium)
                                    .frame(width: 36, height: 36)
                                    .background(Color.black)
                                    .foregroundColor(.red)
                                    .clipShape(Circle())
                                    .shadow(radius: 3)
                            }
                        }
                    }
                }
                .padding(.top, 6)
            }
            .padding()
        }
        .frame(width: 180, height: 240)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [product.color.opacity(0.4), product.color.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: product.color.opacity(0.3), radius: 10, x: 0, y: 8)
    }
}
