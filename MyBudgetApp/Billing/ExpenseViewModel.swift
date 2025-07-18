//
//  ExpenseViewModel.swift
//  MyBudgetApp
//
//  Created by 甘乐言 on 2025/7/9.
//

import Foundation

class ExpenseViewModel: ObservableObject {
    @Published var expenses: [Expense] = []

    func addExpense(title: String, amount: Double, date: Date, category: String) {
        let newExpense = Expense(title: title, amount: amount, date: date, category: category)
        expenses.append(newExpense)
        saveData()
    }

    func saveData() {
        if let data = try? JSONEncoder().encode(expenses) {
            UserDefaults.standard.set(data, forKey: "expenses")
        }
    }
    
    func deleteExpense(at offsets: IndexSet) {
            expenses.remove(atOffsets: offsets)
            saveData()
        }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "expenses"),
           let saved = try? JSONDecoder().decode([Expense].self, from: data) {
            self.expenses = saved
        }
    
    }
    
    var groupedByMonth: [String: [Expense]] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"

        let grouped = Dictionary(grouping: expenses) { (expense) -> String in
            return formatter.string(from: expense.date)
        }

        return grouped.sorted(by: { $0.key > $1.key }).reduce(into: [:]) { $0[$1.key] = $1.value }
    }
    
    var groupedByMonthSorted: [(month: String, items: [Expense])] {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy年MM月"

        let grouped = Dictionary(grouping: expenses) { expense in
            formatter.string(from: expense.date)
        }

        return grouped
            .sorted(by: { $0.key > $1.key }) // 倒序显示月份
            .map { (key, value) in (month: key, items: value) }
    }
}
