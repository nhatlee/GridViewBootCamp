//
//  Weekday.swift
//  CalendarApp
//
//  Created by Nhat Le on 17/5/25.
//


enum Weekday: Int, CaseIterable {
    case mon, tue, wed, thu, fri, sat, sun
    
    var name: String {
        switch self {
        case .mon: return "Mon"
        case .tue: return "Tue"
        case .wed: return "Wed"
        case .thu: return "Thu"
        case .fri: return "Fri"
        case .sat: return "Sat"
        case .sun: return "Sun"
        }
    }
}
