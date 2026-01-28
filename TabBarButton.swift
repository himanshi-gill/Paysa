import SwiftUI

struct TabBarButton: View {
    let icon: String
    let label: String
    let tab: ContentView.Tab
    @Binding var selectedTab: ContentView.Tab
    
    var isSelected: Bool {
        selectedTab == tab
    }
    
    var body: some View {
        Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 28, weight: .semibold))
                
                Text(label)
                    .font(.system(size: 14, weight: .medium))                         .lineLimit(1)
            }
            .foregroundColor(isSelected ? .white : Color(hex: "#8A98AA"))
            .frame(width: 60)
        }
    }
}
