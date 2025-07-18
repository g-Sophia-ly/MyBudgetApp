//
//  Expense.swift
//  MyBudgetApp
//
//  Created by 甘乐言 on 2025/7/9.
//

import Foundation

struct Expense: Identifiable, Codable {
    var id = UUID()
    var title: String
    var amount: Double
    var date: Date
    var category: String
}
