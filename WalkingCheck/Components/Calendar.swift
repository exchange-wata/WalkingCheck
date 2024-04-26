//
//  Calendar.swift
//  WalkingCheck
//
//  Created by 渡辺瑞樹 on 2024/04/25.
//

import SwiftUI

struct CalendarComponent: View {
    let selectedDates: [Date]
    
    var body: some View {
        VStack {
            // カレンダーのヘッダー
            Text("Calendar Header")
                .font(.headline)
            
            // カレンダーの表形式
            // ここで日付を表形式で描画し、選択された日にちは選択状態を示すようにする
            // 実際のカレンダーのデータやレイアウトに応じて調整する必要がある
            VStack {
                ForEach(0..<5, id: \.self) { row in
                    HStack {
                        ForEach(0..<7, id: \.self) { column in
                            let day = row * 7 + column + 1
                            Text("\(day)")
                                .padding(8)
                                .background(self.isSelectedDate(day) ? Color.blue : Color.clear)
                                .clipShape(Circle())
                        }
                    }
                }
            }
            
            // カレンダーのフッター
            Text("Calendar Footer")
                .font(.footnote)
        }
        .padding()
    }
    
    // 選択された日にちかどうかを判定するメソッド
    private func isSelectedDate(_ day: Int) -> Bool {
        // ここでselectedDatesにdayに対応する日付が含まれているかを判定する
        // 今回は適当にdayが奇数の場合を選択されたとみなす
        return day.isMultiple(of: 2)
    }
}

struct CalendarComponent_Previews: PreviewProvider {
    static var previews: some View {
        CalendarComponent(selectedDates: [])
    }
}
