//
//  CalendarView.swfit.swift
//  WalkingCheck
//
//  Created by 渡辺瑞樹 on 2024/04/25.
//

import SwiftUI

struct CalendarView: View {
    @ObservedObject var viewModel: CalendarViewModel
    @ObservedObject var listViewModel: WalkingListViewModel
    
    var body: some View {
        VStack {
            // カレンダーの表示
            CalendarComponent(selectedDates: listViewModel.days.filter { $0.didWalk }.map { $0.date })
        }
    }
}

struct CalendarView_swfit_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(viewModel: CalendarViewModel(), listViewModel: WalkingListViewModel())
    }
}
