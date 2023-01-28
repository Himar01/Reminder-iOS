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
    
    @FetchRequest(
        entity: TaskReminder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskReminder.date, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<TaskReminder>
    
    @State var task: TaskReminder
    var body: some View {
        
        HStack{
            VStack{
                if((task.name) != nil){
                    Text(task.name!).font(.title2).multilineTextAlignment(.leading).lineLimit(1).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 1)
                }
                if((task.date) != nil){
                    Text(itemFormatter.string(from: task.date!)).foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading).padding(.leading, 15)
                }
            }.background( NavigationLink("", destination: ConfigTaskView()).opacity(0) )
            Spacer()
            Button(){
                /* TODO: */
                task.completed = !task.completed
                try? viewContext.save()
            }
                label: {
                    Image(systemName: task.completed ? "checkmark" : "circle")
                }
            }
        .padding()
        .cornerRadius(15)
    }
    
//    private func deleteItems(task: FetchedResults<TaskReminder>) {
//        withAnimation {
//            task.viewContext.delete
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
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

