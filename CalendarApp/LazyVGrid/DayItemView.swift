//
//  DayItemView.swift
//  CalendarApp
//
//  Created by Nhat Le on 17/5/25.
//

import SwiftUI

struct DayItemView: View {
    let dayModel: PracticeDailyModel
    var body: some View {
        VStack(spacing: 4) {
            Text(dayModel.day)
                .font(.headline)
                .foregroundColor(.green)
                .frame(maxHeight: 40, alignment: .center)
            Group {
                Text("Workout: \(dayModel.workout)")
                Text("Sleep: \(dayModel.sleep)")
                Text("Drinks: \(dayModel.drinks)")
            }
            .font(.caption)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(6)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.3))
        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray.opacity(0.3)))
    }
}

#Preview {
    DayItemView(dayModel: PracticeDailyModel.mocked(week: 1)[0])
}
