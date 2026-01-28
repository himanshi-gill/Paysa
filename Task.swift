//
//  SwiftUIView.swift
//  Paysa
//
//  Created by Ramneek kaur on 26/01/26.
//

import SwiftUI

enum TaskType {
    case reward
    case penalty
}

struct Task: Identifiable {
    let id = UUID()
    let title: String
    let avatarImage: String
    let type: TaskType
    let xOffset: CGFloat
    let yOffset: CGFloat
}
