//
//  ContentView-ViewModel.swift
//  Reminder
//
//  Created by Rita Ithaisa on 1/2/23.
//

import Foundation

extension ContentView{
    @MainActor class ViewModel: ObservableObject{
        
        @Published var presentAlert = false
        
        @Published var counter : Int = 0
        
        @Published var isMind : Bool = false
        
        @Published var isCompleted : Bool = false
        
    }
}
