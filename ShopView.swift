import SwiftUI

struct ShopView: View {
    
    @Binding var selectedAvatarImage: String
    @Binding var starsCollected: Int
    
    // MARK: - Data Model for animal and avatar
    struct Animal: Identifiable {
        let id = UUID()
        let name: String
        let imageName: String
        let starCost: Int
    }
    
    struct AvatarItem: Identifiable {
        let id = UUID()
        let name: String
        let imageName: String
        let starCost: Int
    }
    
    // MARK: - Animal List
    let animals: [Animal] = [
        Animal(name: "Brave Cub", imageName: "animal1", starCost: 0),
        Animal(name: "Misty Fox", imageName: "animal2", starCost: 20),
        Animal(name: "Sunny Pup", imageName: "animal3", starCost: 30),
        Animal(name: "Forest Deer", imageName: "animal4", starCost: 40),
        Animal(name: "Snow Bunny", imageName: "animal5", starCost: 50),
        Animal(name: "Night Owl", imageName: "animal6", starCost: 60)
    ]
    
    // MARK: - Mascot List
    let mascots: [AvatarItem] = [
        AvatarItem(name: "Star Buddy", imageName: "ma1", starCost: 40),
        AvatarItem(name: "Moon Pal", imageName: "ma2", starCost: 50),
        AvatarItem(name: "Cloud Friend", imageName: "ma3", starCost: 60),
        AvatarItem(name: "Dream Sprite", imageName: "ma4", starCost: 70)
    ]
    
    
    //    @State private var selectedAnimal: Animal? = nil
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                
                Text("My Collection")
                    .font(.title.bold())
                    .foregroundColor(.white)
                    .padding(.top)
                
                // Selected Avatar
                VStack(spacing: 10) {
                    Image(selectedAvatarImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 170)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(hex: "#F07B0F"), lineWidth: 4))
                        .shadow(radius: 8)
                    
                    Text(animals.first(where: { $0.imageName == selectedAvatarImage })?.name ?? "Avatar")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("Active Avatar")
                        .font(.caption)
                        .foregroundColor(Color(hex: "#E1E1D5"))
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color(hex: "#0B2E52").opacity(0.9))
                .cornerRadius(20)
                .padding(.horizontal)
                
                // Stars Balance
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundColor(Color(hex: "#D1A75C"))
                    Text("Stars: \(starsCollected)")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
                
                // Animals Grid
                HStack {
                    Text("Animals")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 16) {
                    ForEach(animals) { animal in
                        AnimalCard(
                            animal: animal,
                            isSelected: animal.imageName == selectedAvatarImage,
                            starsCollected: $starsCollected,
                            selectedAvatarImage: $selectedAvatarImage
                        )
                    }
                }
                .padding(.horizontal)
                
                // Mascots Grid
                HStack {
                    Text("Mascots")
                        .font(.title3.bold())
                        .foregroundColor(.white)
                    Spacer()
                }
                .padding(.horizontal)
                
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                    ForEach(mascots) { mascot in
                        MascotCard(
                            mascot: mascot,
                            starsCollected: $starsCollected,
                            selectedAvatarImage: $selectedAvatarImage
                        )
                    }
                }
            }
        }
    }
    
    struct AnimalCard: View {
        let animal: ShopView.Animal
        let isSelected: Bool
        
        @Binding var starsCollected: Int
        @Binding var selectedAvatarImage: String
        
        @State private var isUnlocked: Bool = false
        
        var body: some View {
            VStack(spacing: 6) {
                
                Image(animal.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 110)
                
                Text(animal.name)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                if isUnlocked || animal.starCost == 0 {
                    Button("Use") {
                        isUnlocked = true
                        selectedAvatarImage = animal.imageName
                    }
                    .font(.caption2.bold())
                    .padding(6)
                    .background(Color(hex: "#F07B0F"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                } else {
                    Button("⭐ \(animal.starCost)") {
                        if starsCollected >= animal.starCost {
                            starsCollected -= animal.starCost   // ⭐ REAL deduction
                            isUnlocked = true
                            selectedAvatarImage = animal.imageName
                        }
                    }
                    .font(.caption2.bold())
                    .padding(6)
                    .background(Color(hex: "#D1A75C"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding(8)
            .background(Color(hex: "#0B2E52").opacity(0.85))
            .cornerRadius(14)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(isSelected ? Color(hex: "#F07B0F") : Color.clear, lineWidth: 2)
            )
        }
    }
    
    struct MascotCard: View {
        let mascot: ShopView.AvatarItem
        @Binding var starsCollected: Int
        @Binding var selectedAvatarImage: String
        
        @State private var isUnlocked: Bool = false
        
        var body: some View {
            VStack(spacing: 6) {
                Image(mascot.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 110)
                
                Text(mascot.name)
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                if isUnlocked {
                    Button("Use") {
                        selectedAvatarImage = mascot.imageName
                    }
                    .font(.caption2.bold())
                    .padding(6)
                    .background(Color(hex: "#F07B0F"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                } else {
                    Button("⭐ \(mascot.starCost)") {
                        if starsCollected >= mascot.starCost {
                            starsCollected -= mascot.starCost
                            isUnlocked = true
                            selectedAvatarImage = mascot.imageName
                        }
                    }
                    .font(.caption2.bold())
                    .padding(6)
                    .background(Color(hex: "#D1A75C"))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
            }
            .padding(8)
            .background(Color(hex: "#0B2E52").opacity(0.85))
            .cornerRadius(14)
        }
    }
}
    
    #Preview {
        ShopView(
            selectedAvatarImage: .constant("animal1"),
            starsCollected: .constant(120)
        )
    }
