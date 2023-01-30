//
//  TaskView.swift
//  Colores
//
//  Created by Rita Ithaisa on 24/11/22.
//
import Foundation
import SwiftUI

struct TaskView: View {
    @Environment(\.managedObjectContext) private var viewContext
       
    @FetchRequest private var tasks: FetchedResults<TaskReminder>
    
    var task: TaskReminder
    
    var isMind: Bool
    
    init(task: TaskReminder, isMind:  Bool) {
            self.task = task
            self.isMind = isMind
        
            _tasks = FetchRequest<TaskReminder>(
            entity: TaskReminder.entity(),
            sortDescriptors: [NSSortDescriptor(keyPath: \TaskReminder.date, ascending: true)],
            predicate: NSPredicate(format: "id = \(Int64(task.id))"),
            animation: .default)
    }

    
    
    var body: some View {
        
        HStack{
            VStack{
                if((task.name) != nil){
                    Text(task.name!).font(.title2).multilineTextAlignment(.leading).lineLimit(1).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 1).strikethrough(task.completed)
                }
                if((task.date) != nil){
                    /* TODO: show dates correctly */
                    Text(itemFormatter.string(from: task.date!)).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 15)
                }
            }.background( NavigationLink("", destination: ConfigTaskView(index: Int(task.id), isMind: isMind)).opacity(0) )
            Spacer()
            Button(){
                task.completed = !task.completed
                try? viewContext.save()
            }
                label: {
                    Image(systemName: task.completed ? "checkmark" : "circle").resizable().frame(width: 20, height:20)
                }
            }
        .padding()
        .cornerRadius(15)
    }
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MMM, d, yyyy"
    return formatter
}()

// In case of needing counting days from then to now
extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let fromDate = startOfDay(for: from) // <1>
        let toDate = startOfDay(for: to) // <2>
        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate) // <3>
        
        return numberOfDays.day!
    }
}

