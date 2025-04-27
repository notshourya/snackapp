import SwiftUI

struct Home: View {
    
    // Category View Properties
    @State var selectedCategory = "Choco"
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Header
                    HStack {
                        Text("Order From the Best Of Snacks")
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.trailing)
                        
                        Spacer()
                        
                        Image(systemName: "line.3.horizontal")
                            .imageScale(.large)
                            .padding()
                            .frame(width: 70, height: 70)
                            .background(RoundedRectangle(cornerRadius: 50).stroke(Color.black, lineWidth: 1.2))
                    }
                    .padding(.top, 20)
                    
                    // Category List
                    CategoryListView
                        .padding(.top, 10)
                        .padding(.bottom, 10)
                    
                    // Collection List
                    HStack {
                        Text("Choco Collection")
                            .font(.system(size: 24, weight: .bold))
                        
                        Spacer()
                        
                        NavigationLink {
                            CollectionView()
                                .environmentObject(cartManager)
                        } label: {
                            Image(systemName: "arrow.right")
                                .imageScale(.large)
                        }
                        .foregroundColor(.black)
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 10)
                    
                    // Product List
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(productList, id: \.id) { item in
                                ProductCard(product: item)
                                    .environmentObject(cartManager)
                            }
                        }
                    }
                }
                .padding(30)
            }
            .navigationBarBackButtonHidden(true) // Hides the default back button
            .navigationBarHidden(true) // Optionally hides the navigation bar entirely
        }
    }
    
    // Category List View
    var CategoryListView: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(categorylist, id: \.id) { item in
                        Button {
                            selectedCategory = item.title
                        } label: {
                            HStack {
                                if item.title != "All" {
                                    Image(systemName: item.icon)
                                        .foregroundColor(selectedCategory == item.title ? .yellow : .black)
                                }
                                Text(item.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(selectedCategory == item.title ? .white : .black)
                            }
                            .padding(20)
                            .background(selectedCategory == item.title ? Color.black : Color.gray.opacity(0.1))
                            .clipShape(Capsule())
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    Home()
        .environmentObject(CartManager())
}

// Product Card View
struct ProductCard: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    @State private var isAdded = false // State to animate scaling effect

    var body: some View {
        ZStack {
            // Product Image with scaling effect
            Image(product.image)
                .resizable()
                .scaledToFill()
                .padding(.trailing, -60)
                .rotationEffect(Angle(degrees: 25))
                .frame(height: 330)
                .shadow(radius: 20)
                .offset(y: -10)
                .scaleEffect(isAdded ? 1.2 : 1) // Scale effect for image
                .animation(.easeInOut, value: isAdded)
            
            ZStack {
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.system(size: 36, weight: .semibold))
                        .frame(width: 130)
                        .foregroundColor(.black)
                    
                    Text(product.category)
                        .font(.callout)
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(10)
                        .background(Color.black.opacity(0.7))
                        .clipShape(Capsule())
                    
                    Spacer()
                    
                    HStack {
                        Text("₹\(product.price)")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Add to Cart Button
                        Button {
                            cartManager.addToCart(product: product)
                            isAdded.toggle() // Toggle animation when added
                        } label: {
                            Image(systemName: "cart.badge.plus")
                                .imageScale(.large)
                                .frame(width: 65, height: 53)
                                .background(Color.black)
                                .clipShape(Capsule())
                                .foregroundColor(.green)
                                .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 0.5))
                                .scaleEffect(isAdded ? 1.1 : 1) // Scale effect for button
                                .animation(.easeInOut, value: isAdded)
                        }
                        .padding(.horizontal, 1)
                        
                        // Remove from Cart Button (only show if the product is already in the cart)
                        if cartManager.products.contains(where: { $0.id == product.id }) {
                            Button {
                                cartManager.removeFromCart(product: product)
                                isAdded = false // Reset animation when removed
                            } label: {
                                Image(systemName: "cart.badge.minus")
                                    .imageScale(.large)
                                    .frame(width: 65, height: 53)
                                    .background(Color.black)
                                    .clipShape(Capsule())
                                    .foregroundColor(.red)
                                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 0.5))
                            }
                            .padding(.horizontal, 0)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 70)
                    .background(Color.black.opacity(0.9))
                    .clipShape(Capsule())
                }
            }
            .padding(30)
            .frame(width: 336, height: 442)
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [product.color.opacity(0.4), product.color.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .clipShape(RoundedRectangle(cornerRadius: 57))
        .padding(.leading, 20)
    }
}
