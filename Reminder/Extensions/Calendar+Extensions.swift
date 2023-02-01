//
//  Calendar+Extensions.swift
//  Reminder
//
//  Created by Rita Ithaisa on 1/2/23.
//

import Foundation

// In case of needing counting days from then to now
extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}
