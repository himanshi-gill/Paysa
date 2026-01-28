import SwiftUI

struct CreateStoryView: View {
    @Binding var coinsCollected: Int
    @Binding var tasks: [Task]   // 👈 receive tasks from parent
    
    @Binding var selectedAvatarImage: String   // 👈 ADD
    @State private var selectedTaskType: TaskType = .reward

    
    @State private var newTaskTitle = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Create New Task")
                .font(.title)
                .bold()

            TextField("Enter task name", text: $newTaskTitle)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack(spacing: 16) {
                Button {
                    selectedTaskType = .reward
                } label: {
                    Text("Reward +10")
                        .padding()
                        .background(selectedTaskType == .reward ? Color.green : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button {
                    selectedTaskType = .penalty
                } label: {
                    Text("Penalty -15")
                        .padding()
                        .background(selectedTaskType == .penalty ? Color.red : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }


            Button("Add Task") {
                addTask()
            }
            .padding()
            .background(Color(hex: "#F07B0F"))
            .foregroundColor(.white)
            .cornerRadius(12)

            Spacer()
        }
        .padding()
    }

    func addTask() {
        guard !newTaskTitle.isEmpty else { return }

        let coinChange = selectedTaskType == .reward ? 10 : -15
        coinsCollected += coinChange

        let task = Task(
            title: newTaskTitle,
            avatarImage: selectedAvatarImage,
            type: selectedTaskType,
            xOffset: CGFloat.random(in: -120...120),
            yOffset: CGFloat.random(in: -200...200)
        )

        tasks.append(task)
        newTaskTitle = ""
    }
}
