//
//  EditWalkingStatusView.swift
//  WalkingCheck
//
//  Created by 渡辺瑞樹 on 2024/04/26.
//
import SwiftUI

struct EditWalkingStatusView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var didWalk: Bool = false
    let day: WalkingDay
    let viewModel: WalkingListViewModel
    
    var body: some View {
        VStack {
            Text("日付: \(day.dateString)")
                .font(.headline)
                .padding()
            Toggle("この日は走りましたか？", isOn: $didWalk)
                .padding()
            Button("保存する") {
                viewModel.updateWalkingStatus(for: day, didWalk: didWalk)
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
        }
        .padding()
    }
}

struct EditWalkingStatusView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WalkingListViewModel()
        let today = Date()
        let walkingDay = WalkingDay(date: today, dateString: "13日(土)", dayOfWeek: 1, didWalk: false, isSelected: false)
        viewModel.days.append(walkingDay)
        return EditWalkingStatusView(day: walkingDay, viewModel: viewModel)
    }
}

