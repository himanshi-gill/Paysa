import SwiftUI

struct MapView: View {
    @Binding var coinsCollected: Int
    @Binding var starsCollected: Int
    
    @Binding var tasks: [Task]

    var avatarImages: [String] = ["animal1", "mascot1"]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ZStack(alignment: .top) {
                
//                // 🐾 Avatars
//                ForEach(avatarImages.indices, id: \.self) { index in
//                    Image(avatarImages[index])
//                        .resizable()
//                        .frame(width: 45, height: 45)
//                        .position(pointOnPath(progress: CGFloat(index + 1) / CGFloat(avatarImages.count + 2)))
//                }

                // ⭐ Coins & Stars (fixed at top)
                VStack {
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing, spacing: 6) {
                            Text("Coins: \(coinsCollected)")
                                .foregroundColor(Color(hex: "#F07B0F"))
                                .bold()
                            Text("Stars: \(starsCollected)")
                                .foregroundColor(Color(hex: "#D1A75C"))
                                .bold()
                        }
                        .padding(10)
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(12)
                        .padding()
                    }
                    Spacer()
                }
                ZStack {
                    // Loop through tasks
                    ForEach(tasks) { task in
                        VStack(spacing: 6) {
                            Image(task.avatarImage)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(
                                    Circle()
                                        .stroke(task.type == .reward ? Color.green : Color.red, lineWidth: 3)
                                )

                            Text(task.title)
                                .font(.caption)
                                .foregroundColor(.white)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 4)
                                .background(Color.blue)
                                .cornerRadius(10)

                            if task.type == .penalty {
                                Text("-15 Coins")
                                    .font(.caption2)
                                    .foregroundColor(.red)
                            }
                        }
                        .offset(x: task.xOffset, y: task.yOffset)
                        .animation(.spring(), value: tasks.count) // optional for smooth appearance
                    }
                }
                .frame(height: 600) // adjust as needed
            }
        }
    }

    
    func pointOnPath(progress: CGFloat) -> CGPoint {
        let width = UIScreen.main.bounds.width - 100
        let height = UIScreen.main.bounds.height - 200
        
        let x = 50 + width * progress
        let y = 100 + sin(progress * .pi * 2) * (height / 4)
        
        return CGPoint(x: x, y: y)
    }
}


// Task Bubble View (UPDATED)
struct TaskBubble: View {
    var task: Task

    var body: some View {
        VStack(spacing: 6) {
            
//            ForEach(tasks) { task in
//                TaskBubble(task: task)
//                    .offset(x: task.xOffset, y: task.yOffset)
//            }

            Image(task.avatarImage)
                .resizable()
                .frame(width: 36, height: 36)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(
                            task.type == .reward ? Color.green : Color.red,
                            lineWidth: 2
                        )
                )

            Text(task.title)
                .font(.caption2)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.white)
                .cornerRadius(10)

            if task.type == .penalty {
                Text("-15")
                    .font(.caption2)
                    .foregroundColor(.red)
            }
        }
    }
}
