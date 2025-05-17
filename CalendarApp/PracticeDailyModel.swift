//
//  PracticeDailyModel.swift
//  CalendarApp
//
//  Created by Nhat Le on 17/5/25.
//

import Foundation
struct PracticeModel: Hashable {
    let id: Int
    let week: Int
    let days: [PracticeDailyModel]
    let result: DailyPracticeResult
    
    
    static let mocked: [PracticeModel] = (1...20).map {
        let daily = PracticeDailyModel.mocked(week: $0)
        return PracticeModel(
            id: $0,
            week: $0,
            days: daily,
            result: DailyPracticeResult.mocked(daily)
        )
    }
}

struct DailyPracticeResult: Hashable {
    let id = UUID()
    let totalMin: Int
    let actualMin: Int
    let avgSlep: Int
    let totalDrinks: Float
    
    static func mocked(_ daily: [PracticeDailyModel]) -> DailyPracticeResult {
        let total = daily.map {$0.level.min}.reduce(0, +)
        return DailyPracticeResult(totalMin: total, actualMin: 100, avgSlep: 100, totalDrinks: 50.5)
    }
}


extension Float {
    func roundTo(places: Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}

enum PracticeLevel {
    case SixMinEasy
    case SixMinInterval
    case FiveMinMedium
    
    var min: Int {
        switch self {
        case .SixMinEasy:
            return 6
        case .SixMinInterval:
            return 6
        case .FiveMinMedium:
            return 5
        }
    }
    
    var name: String {
        switch self {
        case .SixMinEasy:
            return "6 Min Easy"
        case .SixMinInterval:
            return "6 Min Interval"
        case .FiveMinMedium:
            return "5 Min Medium"
        }
    }
}

struct PracticeDailyModel: Hashable {
    let id: String
    let day: String
    let level: PracticeLevel
    let workout: String
    let sleep: Int
    let drinks: Int
    
    static func mocked(week: Int) -> [PracticeDailyModel] {
        (1...7).map {
            let totalDaysInWeek = 7
            let plusDayNextWeek = (week - 1)*totalDaysInWeek
            let dayString = "Day \($0 + plusDayNextWeek)"
//            print(dayString)
            return PracticeDailyModel(
                id: dayString,
                day: dayString,
                level: randomPractice($0),
                workout: "",
                sleep: 100,
                drinks: 1
            )
        }
    }
    
   static private func randomPractice(_ num: Int) -> PracticeLevel {
        if num % 6 == 0 {
            return .SixMinInterval
        }
        if num % 5 == 0 {
            return .FiveMinMedium
        }
       return .SixMinEasy
    }
    
}
