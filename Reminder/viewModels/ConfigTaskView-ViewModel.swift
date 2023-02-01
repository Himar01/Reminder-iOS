//
//  ConfigTask-ViewModel.swift
//  Reminder
//
//  Created by Rita Ithaisa on 1/2/23.
//

import Foundation

extension ConfigTaskView{
    @MainActor class ViewModel: ObservableObject{
        
        
        @Published var currentDate: Date = Date()
        
        @Published var description: String = ""

        @Published var title: String = ""
        
        @Published var task: TaskReminder? = nil
        
        @Published var newDate: Bool = false
        
        @Published var isLoading: Bool = false
        
        @Published var showInternetAlert: Bool = false
        
        @Published var showPopover: Bool = false
        
        func onRandomClicked(){
            if(!self.isLoading){
                self.isLoading = true
                Api().loadData { (newTasks) in
                    if(newTasks != nil){
                        let newTask = newTasks!.randomElement()
                        self.title = newTask!.name
                        self.description  = newTask!.description
                        self.isLoading = false
                    } else{
                        self.showInternetAlert = true
                        self.isLoading = false
                    }
                }
            }
        }
        
    }
}
