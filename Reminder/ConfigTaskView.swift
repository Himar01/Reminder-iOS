//
//  ConfigTaskView.swift
//  Reminder
//
//  Created by Rita Ithaisa on 27/1/23.
//

import Foundation
import SwiftUI

struct ConfigTaskView: View {

    let isMind: Bool
    var index: Int = -1
    @State var task: TaskReminder? = nil
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: TaskReminder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskReminder.date, ascending: true)],
        animation: .default)
    
    private var tasks: FetchedResults<TaskReminder>
    
    @State var currentDate: Date = Date()
    
    var body: some View {
        VStack{
            Text(task != nil ? task!.name! : "Nada")
            DatePicker("Select Date", selection: $currentDate, displayedComponents: .date)
            Spacer()
        }.onAppear(perform: {
            onCreate()
        }).toolbar {
            ToolbarItem() {
                Button(action: { }) {
                    Label("Add Item", systemImage: "shuffle").tint(.gray)
                }
            }
            ToolbarItem() {
                Button(action: { }) {
                    Label("Add Item", systemImage: "trash").tint(.red)
                }
            }
            ToolbarItem {
                Button(action: { }) {
                    Label("Add Item", systemImage: "checkmark")
                }
            }
        }
    }
    
    private func onCreate(){
        if(index != -1){
            task = tasks[index]
        }
    }
}
