//
//  CalendarView.swift
//  CalendarApp
//
//  Created by Nhat Le on 14/5/25.
//

import SwiftUI
enum Weekday: String, CaseIterable {
    case mon, tue, wed, thu, fri, sat, sun
    
    var value: String {
        self.rawValue.uppercased()
    }
}

struct HeaderRowConfig: Hashable {
    let title: String
    let color: Color
}

final class CalendarViewModel: ObservableObject {
    func buildHeaderString() -> [HeaderRowConfig] {
        let weekTitle = HeaderRowConfig(title: "WEEK", color: .black)
        var header = [weekTitle]
        let allWeekday = Weekday.allCases.map {
            HeaderRowConfig(title: $0.value, color: .blue)
        }
        let totals = HeaderRowConfig(title: "TOTALS", color: .orange)
        header.append(contentsOf: allWeekday)
        header.append(totals)
        return header
    }
    
    func getRunPlan(for week: Int, day: Int) -> String {
        let plan = [
            ["4 Mi Easy", "4 Mi Easy", "4 Mi Easy", "5 Mi Easy", "4 Mi Easy", "8 Mi Easy", "Rest"],
            ["5 Mi Easy", "6 Mi Hills", "5 Mi Easy", "5 Mi Medium", "4 Mi Easy", "9 Mi Easy", "Rest"],
            ["6 Mi Easy", "6 Mi Hills", "5 Mi Easy", "6 Mi Intervals", "4 Mi Easy", "9 Mi Easy", "Rest"],
            ["6 Mi Easy", "6 Mi Medium", "5 Mi Easy", "6 Mi Easy", "4 Mi Easy", "3.1 Mi Fast", "Rest"],
            ["6 Mi Easy", "6 Miles Hills", "5 Mi Easy", "6 Mi Intervals", "6 Mi Easy", "10 Mi Easy", "Rest"],
            ["6 Mi Easy", "5 Mi Fast", "5 Mi Easy", "6 Mi Easy", "30 Min XT", "3.1 Race Day!", "Rest"],
            ["4 Mi Easy", "4 Mi Easy", "4 Mi Easy", "5 Mi Easy", "4 Mi Easy", "8 Mi Easy", "Rest"],
            ["5 Mi Easy", "6 Mi Hills", "5 Mi Easy", "5 Mi Medium", "4 Mi Easy", "9 Mi Easy", "Rest"],
            ["6 Mi Easy", "6 Mi Hills", "5 Mi Easy", "6 Mi Intervals", "4 Mi Easy", "9 Mi Easy", "Rest"],
            ["6 Mi Easy", "6 Mi Medium", "5 Mi Easy", "6 Mi Easy", "4 Mi Easy", "3.1 Mi Fast", "Rest"],
            ["6 Mi Easy", "6 Miles Hills", "5 Mi Easy", "6 Mi Intervals", "6 Mi Easy", "10 Mi Easy", "Rest"],
            ["6 Mi Easy", "5 Mi Fast", "5 Mi Easy", "6 Mi Easy", "30 Min XT", "3.1 Race Day!", "Rest"],
            ["4 Mi Easy", "4 Mi Easy", "4 Mi Easy", "5 Mi Easy", "4 Mi Easy", "8 Mi Easy", "Rest"],
            ["5 Mi Easy", "6 Mi Hills", "5 Mi Easy", "5 Mi Medium", "4 Mi Easy", "9 Mi Easy", "Rest"],
            ["6 Mi Easy", "6 Mi Hills", "5 Mi Easy", "6 Mi Intervals", "4 Mi Easy", "9 Mi Easy", "Rest"],
            ["6 Mi Easy", "6 Mi Medium", "5 Mi Easy", "6 Mi Easy", "4 Mi Easy", "3.1 Mi Fast", "Rest"],
            ["6 Mi Easy", "6 Miles Hills", "5 Mi Easy", "6 Mi Intervals", "6 Mi Easy", "10 Mi Easy", "Rest"],
            ["6 Mi Easy", "5 Mi Fast", "5 Mi Easy", "6 Mi Easy", "30 Min XT", "3.1 Race Day!", "Rest"]
        ]
        return plan[week][day]
    }
    
    func getWeekTotal(for week: Int) -> String {
        let totals = ["31", "34", "36", "30.1", "37", "24.1", "31", "34", "36", "30.1", "37", "24.1", "31", "34", "36", "30.1"]
        return totals[week]
    }
    
    @Published var numbersOfWeeks: Int = 16
}

struct CalendarView: View {
    let columns = [
        GridItem(.fixed(70)),  // WEEK
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
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                // Header Row
                ForEach(viewModel.buildHeaderString(), id: \.self) { config in
                    Text(config.title)
                        .font(.system(size: 12, weight: .bold))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding()
                        .background(
                            config.color
                        )
                        .foregroundColor(.white)
                }
                
                // Week Rows
                ForEach(0..<viewModel.numbersOfWeeks) { week in
                    // WEEK cell
                    Text("\(week + 1)")
                        .font(.body)
                        .bold()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black)
                        .foregroundColor(.white)
                    
                    // Day Cells
                    ForEach(0..<7) { day in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Day \(week * 7 + day + 1)")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(viewModel.getRunPlan(for: week, day: day))
                                .font(.subheadline)
                                .bold()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .frame(height: 90)
                        .padding(6)
                        .background(Color.gray.opacity(0.3))
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray.opacity(0.3)))
                    }
                    
                    // Totals Cell
                    Text(viewModel.getWeekTotal(for: week))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.white)
                }
            }
            .padding()
        }
    }
}

#Preview {
    CalendarView()
}
