import SwiftUI

struct Quest: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let totalRequired: Int
    let starReward: Int
    
    var progress: Int = 0
    var isCompleted: Bool {
        progress >= totalRequired
    }
}

//MARK;- streak Model
struct StreakQuest: Identifiable {
    let id = UUID()
    let title: String
    let daysRequired: Int
    let coinReward: Int
    
    var currentDays: Int = 0
    
    var isCompleted: Bool {
        currentDays >= daysRequired
    }
}
