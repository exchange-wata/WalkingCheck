//
//  WalkingDay.swift
//  WalkingCheck
//
//  Created by 渡辺瑞樹 on 2024/04/25.
//

import Foundation

struct WalkingDay: Identifiable, Codable {
    let id = UUID()
    let date: Date
    let dateString: String
    let dayOfWeek: Int
    var didWalk: Bool
    var isSelected: Bool
}
