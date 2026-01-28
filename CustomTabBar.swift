import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: ContentView.Tab
    
    var body: some View {
        ZStack {
            
            RoundedRectangle(cornerRadius: 30)
                .fill(Color(hex: "#0B2E52").opacity(0.95))
                .frame(height: 75)
                .shadow(color: Color(hex: "#061732"), radius: 10, y: -5)
            
            HStack {
                TabBarButton(icon: "map.fill",label: "Verse", tab: .map, selectedTab: $selectedTab)
                Spacer()
                TabBarButton(icon: "scroll.fill", label: "Quests", tab: .quests, selectedTab: $selectedTab)
                
                Spacer().frame(width: 70)
                
                TabBarButton(icon: "cart.fill", label: "Shop", tab: .shop, selectedTab: $selectedTab)
                Spacer()
                TabBarButton(icon: "person.fill", label:  "Me", tab: .profile, selectedTab: $selectedTab)
            }
            .padding(.horizontal, 30)
            
            Button {
                selectedTab = .create
            } label: {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(hex: "#F07B0F"),
                                    Color(hex: "#D1A75C")
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(width: 65, height: 65)
                        .shadow(color: .black.opacity(0.4), radius: 6, y: 4)
                    
                    Image(systemName: "plus")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .offset(y: -35)
        }
        .padding(.horizontal)
        .padding(.bottom, 10)
    }
}
