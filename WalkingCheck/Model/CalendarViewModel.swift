//
//  CalendarViewModel.swift
//  WalkingCheck
//
//  Created by 渡辺瑞樹 on 2024/04/25.
//

import Foundation

class CalendarViewModel: ObservableObject {
    @Published var selectedDate: Date?
    @Published var walkingDays: [Date] // ウォーキングをした日の配列
    
    init() {
        // ここでウォーキングをした日の配列を取得するなどの初期化処理を行う
        self.walkingDays = []
    }
}
