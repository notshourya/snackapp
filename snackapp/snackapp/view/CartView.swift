import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartManager: CartManager
    @Environment(\.presentationMode) var mode
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    // Header Section
                    HStack {
                        // Title: "Your Cart"
                        Text("Your Cart")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                        
                        Spacer()
                        
                        // Cart Item Count Badge
                        Button {
                            mode.wrappedValue.dismiss()
                        } label: {
                            ZStack {
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 60, height: 60)
                                    .shadow(radius: 5)
                                
                                Text("\(cartManager.products.count)")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.trailing, 20)
                    }
                    .padding(.vertical, 20)
                    
                    // Cart Product List
                    ForEach(cartManager.products, id: \.id) { item in
                        CardProductCard(product: item)
                            .swipeActions {
                                Button(role: .destructive) {
                                    cartManager.removeFromCart(product: item)
                                } label: {
                                    Label("Remove", systemImage: "trash")
                                }
                            }
                    }
                    
                    // Total Amount Section
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Delivery")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                            Spacer()
                            Text("Free")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("Total Amount")
                                .font(.headline)
                                .foregroundColor(.white)
                            Spacer()
                            Text("INR \(cartManager.total)")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.orange)
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(1))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    
                    // Make Payment Button
                    Button {
                        // Action for payment
                    } label: {
                        Text("Proceed to Payment")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.orange)
                            .cornerRadius(20)
                            .padding([.leading, .trailing], 20)
                            .padding(.top, 20)
                    }
                }
                .padding(.bottom, 30)
            }
            .navigationBarBackButtonHidden(true) // This hides the default back button
            .navigationBarHidden(true) // This hides the whole navigation bar
        }
    }
}

struct CardProductCard: View {
    
    var product: Product
    @EnvironmentObject var cartManager: CartManager
    
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .padding(5)
                .frame(width: 110, height: 125)
                .background(.gray.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.leading)
            
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                    .fontWeight(.bold)
                Text(product.category)
                    .font(.callout)
                    .opacity(0.7)
            }
            
            Spacer()
            
            VStack {
                Text("₹\(product.price)")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .padding(8)
                    .background(Color.orange.opacity(0.8))
                    .foregroundColor(.black)
                    .clipShape(Capsule())
                
                Button {
                    cartManager.removeFromCart(product: product)
                } label: {
                    Image(systemName: "trash.fill")
                        .foregroundColor(.red.opacity(0.9))
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Circle())
                        .shadow(radius: 1)
                        
                }
                .padding(.top, 5)
            }
            .padding(.trailing)
        }
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(12)
        Divider()
        
    }
}
