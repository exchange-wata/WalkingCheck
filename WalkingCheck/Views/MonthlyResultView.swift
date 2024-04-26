//
//  MonthlyResultView.swift
//  WalkingCheck
//
//  Created by 渡辺瑞樹 on 2024/04/25.
//

import SwiftUI

struct MonthlyResultView: View {
    @ObservedObject var viewModel: WalkingListViewModel
    
    var body: some View {
        ZStack {
            backgroundImage
            monthlyResult
        }
    }
}


struct MonthlyResultView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyResultView(viewModel: WalkingListViewModel())
    }
}

extension MonthlyResultView {
    private var backgroundImage: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                ForEach(0..<Int(geometry.size.height / 20)) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<Int(geometry.size.width / 20)) { column in
                            Image(systemName: "hands.clap")
                                .font(.system(size: 50))
                                .foregroundColor(.yellow)
                                .position(x: CGFloat(column * 100 + (row % 2 == 0 ? 50 : 0)), y: CGFloat(row * 100 + 50))
                                .opacity(0.5)
                        }
                    }
                }
            }
        }
    }
    
    private var monthlyResult: some View {
        VStack {
            Text("合計")
                .font(.title2)
            
            Text("\(totalDays())日中、\(totalWalkingDays())日")
                .font(.largeTitle)
            
            Text("走りました！")
                .font(.title2)
        }

    }
    
    // 月間の走行日数の合計を計算するメソッド
    private func totalWalkingDays() -> Int {
        var count = 0
        for day in viewModel.days {
            if day.didWalk {
                count += 1
            }
        }
        return count
    }
    
    // 月間の合計日数を返す
    private func totalDays() -> Int  {
        return viewModel.days.count + 1
    }

}
