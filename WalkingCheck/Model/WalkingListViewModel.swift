//
//  WalkingListViewModel.swift
//  WalkingCheck
//
//  Created by 渡辺瑞樹 on 2024/04/25.
//
import Foundation


class WalkingListViewModel: ObservableObject {
    @Published var days: [WalkingDay]
    
    init() {
        self.days = Self.generateDaysForCurrentMonth()
        self.loadFromUserDefaults()
    }
    
    func updateWalkingStatus(for day: WalkingDay, didWalk: Bool) {
        if let index = days.firstIndex(where: { $0.id == day.id }) {
            days[index].didWalk = didWalk
            saveToUserDefaults()
        }
    }
    
    func updateSelection(for day: WalkingDay, isSelected: Bool) {
        if let index = days.firstIndex(where: { $0.id == day.id }) {
            days[index].isSelected = isSelected
        }
    }

    private static func generateDaysForCurrentMonth() -> [WalkingDay] {
        let calendar = Calendar.current
        let currentDate = Date()
        let currentMonth = calendar.component(.month, from: currentDate)
        let currentYear = calendar.component(.year, from: currentDate)
        
        let startOfMonth = calendar.date(from: DateComponents(year: currentYear, month: currentMonth, day: 1))!
        let endOfMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfMonth)!
        
        var days: [WalkingDay] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP") // 日本のロケールを指定
        dateFormatter.dateFormat = "d日(E)" // 曜日を日本語で表示

        calendar.enumerateDates(startingAfter: startOfMonth, matching: DateComponents(hour: 0, minute: 0, second: 0), matchingPolicy: .nextTime) { (date, _, stop) in
            guard let date = date, date <= endOfMonth else {
                stop = true
                return
            }
            
            let dayOfWeek = calendar.component(.weekday, from: date)
            let dateString = dateFormatter.string(from: date)
            
            days.append(WalkingDay(date: date, dateString: dateString, dayOfWeek: dayOfWeek, didWalk: false, isSelected: false))
        }
        
        return days
    }
    // UserDefaultsからデータを読み込む
    private func loadFromUserDefaults() {
        if let savedDays = UserDefaults.standard.object(forKey: "savedDays") as? Data {
            let decoder = JSONDecoder()
            if let loadedDays = try? decoder.decode([WalkingDay].self, from: savedDays) {
                self.days = loadedDays
            }
        }
    }
    
    // データをUserDefaultsに保存する
    private func saveToUserDefaults() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(self.days) {
            UserDefaults.standard.set(encoded, forKey: "savedDays")
        }
    }
}
