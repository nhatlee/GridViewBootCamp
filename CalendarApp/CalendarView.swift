//
//  CalendarView.swift
//  CalendarApp
//
//  Created by Nhat Le on 14/5/25.
//

import SwiftUI

struct CalendarView: View {
    let columns = [
            GridItem(.flexible()), // MON
            GridItem(.flexible()), // TUE
            GridItem(.flexible()), // WED
            GridItem(.flexible()), // THU
            GridItem(.flexible()), // FRI
            GridItem(.flexible()), // SAT
            GridItem(.flexible()), // SUN
            GridItem(.fixed(60))   // TOTALS
        ]
        
        var body: some View {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 8) {
                    // Header
                    ForEach(["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN", "TOTALS"], id: \.self) { title in
                        Text(title)
                            .font(.body)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue.opacity(0.8))
                            .foregroundColor(.white)
                    }
                    
                    // Weeks
                    ForEach(0..<6) { week in
                        ForEach(0..<8) { day in
                            if day == 7 {
                                // Totals column
                                Text(["31", "34", "36", "30.1", "37", "24.1"][week])
                                    .frame(maxWidth: .infinity, minHeight: 80)
                                    .background(Color.green.opacity(0.3))
                            } else {
                                // Day cell
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Day \(week * 7 + day + 1)")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(getRunPlan(for: week, day: day))
                                        .font(.subheadline)
                                        .bold()
                                }
                                .frame(maxWidth: .infinity, alignment: .topLeading)
                                .padding(6)
                                .background(Color.white)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray.opacity(0.3)))
                            }
                        }
                    }
                }
                .padding()
            }
        }
        
        func getRunPlan(for week: Int, day: Int) -> String {
            // Replace with actual data mapping from your image
            let plan = [
                ["4 Mi Easy", "4 Mi Easy", "4 Mi Easy", "5 Mi Easy", "4 Mi Easy", "8 Mi Easy", "Rest"],
                ["5 Mi Easy", "6 Mi Hills", "5 Mi Easy", "5 Mi Medium", "4 Mi Easy", "9 Mi Easy", "Rest"],
                ["6 Mi Easy", "6 Mi Hills", "5 Mi Easy", "6 Mi Intervals", "4 Mi Easy", "9 Mi Easy", "Rest"],
                ["6 Mi Easy", "6 Mi Medium", "5 Mi Easy", "6 Mi Easy", "4 Mi Easy", "3.1 Mi Fast", "Rest"],
                ["6 Mi Easy", "6 Miles Hills", "5 Mi Easy", "6 Mi Intervals", "6 Mi Easy", "10 Mi Easy", "Rest"],
                ["6 Mi Easy", "4 Mi Fast", "5 Mi Easy", "6 Mi Easy", "30 Min XT", "3.1 Race Day!", "Rest"]
            ]
            return plan[week][day]
        }
}

#Preview {
    RunningPlanView()
}


struct RunningPlanView: View {
    let columns = [
        GridItem(.fixed(60)),  // WEEK
        GridItem(.flexible()), // MON
        GridItem(.flexible()), // TUE
        GridItem(.flexible()), // WED
        GridItem(.flexible()), // THU
        GridItem(.flexible()), // FRI
        GridItem(.flexible()), // SAT
        GridItem(.flexible()), // SUN
        GridItem(.fixed(60))   // TOTALS
    ]
    
    let headers = ["WEEK", "MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN", "TOTALS"]
    
    private func titleBackGround(_ title: String) -> Color {
        if title == headers.first {
            return .black
        } else if title == headers.last {
            return .orange
        }
        return .blue
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 8) {
                // Header Row
                ForEach(headers, id: \.self) { title in
                    Text(title)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            titleBackGround(title)
                        )
                        .foregroundColor(.white)
                }
                
                // Week Rows
                ForEach(0..<6) { week in
                    // WEEK cell
                    Text("\(week + 1)")
                        .font(.body)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .frame(height: 90)
//                        .padding()
                        .background(Color.black)
                        .foregroundColor(.white)
                    
                    // Day Cells
                    ForEach(0..<7) { day in
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Day \(week * 7 + day + 1)")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Text(getRunPlan(for: week, day: day))
                                .font(.subheadline)
                                .bold()
                        }
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .frame(height: 90)
                        .padding(6)
                        .background(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.gray.opacity(0.3)))
                    }
                    
                    // Totals Cell
                    Text(getWeekTotal(for: week))
                        .frame(maxWidth: .infinity)
                        .frame(height: 90)
                        .background(.white)
                }
            }
            .padding()
        }
    }
    
    
    
    func getRunPlan(for week: Int, day: Int) -> String {
        let plan = [
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
        let totals = ["31", "34", "36", "30.1", "37", "24.1"]
        return totals[week]
    }
}
