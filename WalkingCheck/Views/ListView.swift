//
//  ListView.swfit.swift
//  WalkingCheck
//
//  Created by 渡辺瑞樹 on 2024/04/25.
//

import SwiftUI

struct ListView: View {
    @ObservedObject var viewModel: WalkingListViewModel
    @State private var selectedDate: WalkingDay?
    
    let currentDate = Date()
    
    var body: some View {
        VStack {
            ListExplain
            List(viewModel.days) { day in
                HStack {
                    days(for: day)
                    if day.date <= Date() {
                        Button(action: {
                            selectedDate = day
                        }) {
                            HStack {
                                Spacer()
                                isWalking(for: day)
                                Spacer()
                                isNotWalking(for: day)
                                Spacer()
                            }
                        }
                        .disabled(day.date > Date()) // 過去の日は編集不可
                    }
                }
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: WalkingListViewModel())
    }
}

extension ListView {
    private var ListExplain: some View {
        Text("走ったら\(Image(systemName: "checkmark.circle.fill"))、走らなかったら\(Image(systemName:"xmark.circle.fill"))を押してください。")
            .font(.subheadline)
            .foregroundColor(.gray)
    }
    
    private func days(for day: WalkingDay) -> some View {
        Text(day.dateString)
            .foregroundColor(day.date > Date() ? Color.gray : Color.black)
    }
    
    private func isWalking(for day: WalkingDay) -> some View {
        Image(systemName: "checkmark.circle.fill")
            .foregroundColor(day.isSelected == false ? .gray : (day.didWalk == true ? .green : .gray))
            .onTapGesture {
                viewModel.updateSelection(for: day, isSelected: true)
                viewModel.updateWalkingStatus(for: day, didWalk: true)
            }
    }
    
    private func isNotWalking(for day: WalkingDay) -> some View {
        Image(systemName: "xmark.circle.fill")
            .foregroundColor(day.isSelected == false ? .gray : (day.didWalk == false ? .red : .gray))
            .onTapGesture {
                viewModel.updateSelection(for: day, isSelected: true)
                viewModel.updateWalkingStatus(for: day, didWalk: false)
            }
    }
}
