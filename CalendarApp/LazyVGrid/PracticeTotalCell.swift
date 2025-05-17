//
//  PracticeTotalCell.swift
//  CalendarApp
//
//  Created by Nhat Le on 17/5/25.
//

import SwiftUI

struct PracticeTotalCell: View {
    let result: DailyPracticeResult
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(result.totalMin)")
                .font(.title)
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
            Group {
                Text("Actual Min: \(result.actualMin)")
                Text("AvgSleep: \(result.avgSlep)")
                Text("Tot Drinks: \(String(format: "%.2f", result.totalDrinks))")
            }
            .font(.system(size: 10))
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    PracticeTotalCell(result: DailyPracticeResult.mocked(PracticeDailyModel.mocked(week: 1)))
}
