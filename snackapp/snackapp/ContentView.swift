//
//  ContentView.swift
//  snackapp
//
//  Created by Shourya Thakur on 4/25/25.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var cartManager = CartManager()
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottom) {
                Home()
                    .environmentObject(cartManager)
                
                if cartManager.products.count >= 0 {
                    NavigationLink(destination: CartView().environmentObject(cartManager)){
                        HStack(spacing: 16) {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: "cart.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.black.opacity(0.7))
                                    .clipShape(Circle())
                                    .shadow(radius: 10)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 0.5))
                      
                                
                                if cartManager.products.count > 0 {
                                    Text("\(cartManager.products.count)")
                                        .font(.caption2)
                                        .foregroundColor(.black)
                                        .padding(6)
                                        .background(Color.orange)
                                        .clipShape(Circle())
                                        .offset(x: 12, y: -12)
                                        .transition(.scale)
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Your Cart")
                                    .font(.custom("Helvetica Neue", size: 18))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                
                                Text("\(cartManager.products.count) item(s)")
                                    .font(.custom("Helvetica Neue", size: 14))
                                    .foregroundColor(.white.opacity(0.8))
                            }
                            
                            Spacer()
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: -10) {
                                    ForEach(cartManager.products, id: \.name) { product in
                                        Image(product.image)
                                            .resizable()
                                            .background(.white)
                                            .scaledToFit()
                                            .frame(width: 45, height: 45)
                                            .clipShape(Circle())
                                            .shadow(radius: 5)
                                            .opacity(0.8)
                                            .transition(.opacity)
                                            
                                    }
                                }
                                .frame(height: 55)
                            }
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 20)
                        .background(Color.black.opacity(0.9))
                        .clipShape(RoundedRectangle(cornerRadius: 60))
                        .shadow(radius: 20)
                        .frame(maxWidth: .infinity)
                        .animation(.easeInOut(duration: 0.5), value: cartManager.products.count)
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    ContentView()
}
