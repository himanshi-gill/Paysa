import SwiftUI

struct ContentView: View {

    enum Tab {
        case map, quests, create, shop, profile
    }

    @State private var selectedTab: Tab = .map

    @State private var userName: String = ""
    @State private var selectedAvatarImage: String = "animal1"
    @State private var coinGoal: Int = 3000
    @State private var coinsCollected: Int = 850
    @State private var starsCollected: Int = 120
    
    @State private var tasks: [Task] = []


    var body: some View {
        ZStack {
//            LinearGradient(
//                colors: [
//                    Color(hex: "#061732"),
//                    Color(hex: "#0E3867"),
//                    Color(hex: "#5E677A")
//                ],
//                startPoint: .top,
//                endPoint: .bottom
//            )
//            .ignoresSafeArea()

            Image("it")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

            VStack {
                Spacer()

                currentTabView()   // ✅ just CALL it here

                Spacer()

                CustomTabBar(selectedTab: $selectedTab)
            }
        }
    }

    // ✅ FUNCTION GOES HERE (outside body)
    @ViewBuilder
    private func currentTabView() -> some View {
        switch selectedTab {
        case .map:
            MapView(
                coinsCollected: $coinsCollected,
                starsCollected: $starsCollected,
                tasks: $tasks
            )

        case .quests:
            QuestsView(
                starsCollected: $starsCollected,
                coinsCollected: $coinsCollected
            )

        case .create:
            CreateStoryView(
                coinsCollected: $coinsCollected,
                tasks: $tasks,
                selectedAvatarImage: $selectedAvatarImage
            )

        case .shop:
            ShopView(
                selectedAvatarImage: $selectedAvatarImage,
                starsCollected: $starsCollected
            )

        case .profile:
            ProfileView(
                userName: $userName,
                selectedAvatarImage: $selectedAvatarImage,
                coinGoal: $coinGoal,
                coinsCollected: $coinsCollected,
                starsCollected: $starsCollected,
            )
        }
    }
}
