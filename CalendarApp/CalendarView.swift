//
//  CalendarView.swift
//  CalendarApp
//
//  Created by Nhat Le on 14/5/25.
//

import SwiftUI
import Combine

struct HeaderRowConfig: Hashable {
    let id = UUID()
    let title: String
    let color: Color
}

final class CalendarViewModel: ObservableObject {
    var practices: [PracticeModel] = PracticeModel.mocked
    
    func buildHeaderString() -> [HeaderRowConfig] {
        let weekTitle = HeaderRowConfig(title: "WEEK", color: .black)
        var header = [weekTitle]
        let allWeekday = Weekday.allCases.map {
            HeaderRowConfig(title: $0.name, color: .blue)
        }
        let totals = HeaderRowConfig(title: "TOTALS", color: .orange)
        header.append(contentsOf: allWeekday)
        header.append(totals)
        return header
    }
}

struct CalendarView: View {
    let columns = [
        GridItem(.fixed(68)),  // WEEK
        GridItem(.flexible()), // MON
        GridItem(.flexible()), // TUE
        GridItem(.flexible()), // WED
        GridItem(.flexible()), // THU
        GridItem(.flexible()), // FRI
        GridItem(.flexible()), // SAT
        GridItem(.flexible()), // SUN
        GridItem(.flexible())   // TOTALS
    ]
    
    @StateObject private var viewModel = CalendarViewModel()
    @State private var practicesModel = PracticeModel.mocked
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                // Header Row
                hederView
                weekRow
            }
            .padding()
        }
    }
    
    private var hederView: some View {
        ForEach(viewModel.buildHeaderString(), id: \.self) { config in
            Text(config.title)
                .font(.system(size: 12, weight: .bold))
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .background(config.color)
                .foregroundColor(.white)
        }
    }
    
    private var weekRow: some View {
        // Week Rows
        ForEach(practicesModel, id: \.self) { practiveModel in
            // WEEK cell
            weekCell(practiveModel.week)
            // Day Cells
            dayCell(practiveModel.days)
            // Totals Cell
            totalCell(practiveModel.result)
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
            dayRow(day)
        }
    }
    
    private func dayRow(_ dayModel: PracticeDailyModel) -> some View {
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
    
    private func totalCell(_ result: DailyPracticeResult) -> some View {
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
    CalendarView()
}
