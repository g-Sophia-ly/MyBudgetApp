//
//  ContentView.swift
//  MyBudgetApp
//
//  Created by 甘乐言 on 2025/7/9.
//

import SwiftUI

struct ContentView: View {
    @State private var showAlert = false
    @State private var deleteOffsets: IndexSet?
    @StateObject var viewModel = ExpenseViewModel()
    @State private var isEditing = false
    @State private var selectedItems = Set<UUID>()

    var body: some View {
        NavigationView {
            List(selection: isEditing ? $selectedItems : .constant([])) {
                ForEach(viewModel.groupedByMonthSorted, id: \.month) { group in
                    Section(header: Text(group.month).font(.headline)) {
                        ForEach(group.items) { expense in
                            VStack(alignment: .leading) {
                                Text(expense.title).font(.headline)
                                Text("¥\(expense.amount, specifier: "%.2f")").foregroundColor(.gray)
                                Text(expense.date, style: .date).font(.caption).foregroundColor(.secondary)
                            }
                        }
                    }
                }
            }
            .environment(\.editMode, .constant(isEditing ? EditMode.active : EditMode.inactive))
            .navigationTitle("账单")
            .toolbar {
                // 这个按钮可以设计跳转到图表视图
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                    }) {
                        Text("需要修改功能按钮")
                    }
                }

                // 右上角多选按钮
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "完成" : "多选") {
                        isEditing.toggle()
                        if !isEditing { selectedItems.removeAll() }
                    }
                }
            }
            .overlay(
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: AddExpenseView(viewModel: viewModel)) {
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.blue)
                                .padding()
                        }
                        Spacer()
                    }
                }
            )
        }
        
        .alert("确定要删除这笔账目吗？", isPresented: $showAlert) {
            Button("取消", role: .cancel) { }
            Button("删除", role: .destructive) {
                if let offsets = deleteOffsets {
                    viewModel.deleteExpense(at: offsets)
                }
            }
        }
        .onAppear {
            viewModel.loadData()
        }
    }

    func deleteSelectedItems() {
        let idsToDelete = selectedItems
        viewModel.expenses.removeAll { idsToDelete.contains($0.id) }
        viewModel.saveData()
        selectedItems.removeAll()
    }
    
}


#Preview {
    ContentView()
}


