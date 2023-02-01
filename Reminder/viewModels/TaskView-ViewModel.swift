//
//  TaskView-ViewModel.swift
//  Reminder
//
//  Created by Rita Ithaisa on 1/2/23.
//

import Foundation

extension TaskView{
    @MainActor class ViewModel: ObservableObject{
        
        
        
        
        let itemFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM, d, yyyy"
            return formatter
        }()
        
    }
}
