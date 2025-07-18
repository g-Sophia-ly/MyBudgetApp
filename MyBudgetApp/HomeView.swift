//
//  HomeView.swift
//  MyBudgetApp
//
//  Created by 甘乐言 on 2025/7/9.
//

import SwiftUI

struct HomeView: View {
    @State private var goToAddExpense = false
    @State private var goToContent = false
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

        var body: some View {
            NavigationView {
                LazyVGrid(columns: columns, spacing: 20) {
                    NavigationLink(destination: AddExpenseView(viewModel: ExpenseViewModel())) {
                        HomeButton(title: "新增", systemImage: "plus.circle", color: .black)
                    }

                    NavigationLink(destination: ContentView()) {
                        HomeButton(title: "账单", systemImage: "list.bullet.rectangle", color: .black)
                    }

                    HomeButton(title: "统计", systemImage: "chart.bar", color: .black)

                    HomeButton(title: "我的", systemImage: "person.circle", color: .black)

                }
                .padding()
                .navigationTitle("主页面")
            }
        }
}

#Preview {
    HomeView()
}

