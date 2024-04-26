//
//  ContentView.swift
//  WalkingCheck
//
//  Created by 渡辺瑞樹 on 2024/04/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var listViewModel = WalkingListViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Text(currentMonthName())

                TabView(selection: $selectedTab) {
                    ListView(viewModel: listViewModel)
                        .tabItem {
                            Label("一覧", systemImage: "list.bullet")
                                .font(.title2)
                        }
                        .tag(0)
                    
                    MonthlyResultView(viewModel: listViewModel)
                        .tabItem {
                            Label("\(currentMonthName())の結果", systemImage: "calendar")
                                .font(.title2)
                        }
                        .tag(1)
                }
                .navigationTitle("シンプルウォーキングログ")
                .navigationBarTitleDisplayMode(.inline) // タイトルをインライン表示に設定
                .font(.title2) // タイトルのフォントサイズを変更
            }
        }
    }
    
    private func currentMonthName() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP") // 日本のロケールを指定
        dateFormatter.dateFormat = "M月"
        return dateFormatter.string(from: Date())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
