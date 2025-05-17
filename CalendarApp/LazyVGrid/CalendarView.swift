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
                WeeklyPracticeRow(practicesModel)
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
}

#Preview {
    CalendarView()
}
