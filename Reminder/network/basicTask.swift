//
//  simpleTask.swift
//  Reminder
//
//  Created by Rita Ithaisa on 30/1/23.
//

import Foundation

struct basicTask: Codable,Identifiable {
    let id = UUID()
    var name: String
    var description: String
    var completed: Bool
    var date: String
}
