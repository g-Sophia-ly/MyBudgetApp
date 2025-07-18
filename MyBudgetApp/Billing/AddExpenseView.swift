//
//  AddExpenseView.swift
//  MyBudgetApp
//
//  Created by 甘乐言 on 2025/7/9.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: ExpenseViewModel

    @State private var title = ""
    @State private var amount = ""
    @State private var date = Date()
    @State private var category = ""

    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Amount", text: $amount)
                .keyboardType(.decimalPad)
            TextField("Category", text: $category)
            DatePicker("Date", selection: $date, displayedComponents: .date)

            Button("Save") {
                if let actualAmount = Double(amount) {
                    viewModel.addExpense(title: title, amount: actualAmount, date: date, category: category)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .navigationTitle("添加账目")
    }
}

#Preview {
    AddExpenseView(viewModel: ExpenseViewModel())
}


