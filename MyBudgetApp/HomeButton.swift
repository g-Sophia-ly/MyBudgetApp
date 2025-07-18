//
//  HomeButton.swift
//  MyBudgetApp
//
//  Created by 甘乐言 on 2025/7/9.
//

import SwiftUI

struct HomeButton: View {
    let title: String
    let systemImage: String
    let color: Color 

    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
                .foregroundColor(color)
            Text(title)
                .font(.headline)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color.blue.opacity(0.1))
        .cornerRadius(15)
    }
}




