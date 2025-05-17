//
//  WeeklyPracticeRow.swift
//  CalendarApp
//
//  Created by Nhat Le on 17/5/25.
//

import SwiftUI

struct WeeklyPracticeRow: View {
    let practiveModel: [PracticeModel]
    init(_ practiveModel: [PracticeModel]) {
        self.practiveModel = practiveModel
    }
    
    var body: some View {
        ForEach(practiveModel, id: \.self) { practiveModel in
            weekCell(practiveModel.week)
            dayCell(practiveModel.days)
            PracticeTotalCell(result: practiveModel.result)
        }
    }
    
    private func weekCell(_ week: Int) -> some View {
        Text("\(week)")
            .font(.body)
            .bold()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.black)
            .foregroundColor(.white)
    }
    
    private func dayCell(_ days: [PracticeDailyModel]) -> some View {
        ForEach(days, id: \.id) { day in
            DayItemView(dayModel: day)
        }
    }
}

#Preview {
    WeeklyPracticeRow(PracticeModel.mocked)
}
