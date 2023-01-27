//
//  ContentView.swift
//  Reminder
//
//  Created by Rita Ithaisa on 27/1/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: TaskReminder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \TaskReminder.date, ascending: true)],
        animation: .default)
    private var tasks: FetchedResults<TaskReminder>
    
    @State var isMind : Bool = false

    
    var body: some View {
        NavigationView {
            ZStack {
                     Color.white
                         .ignoresSafeArea()
                VStack{
                    HStack{
                        Button {
                            isMind = true
                        } label: {
                            Text("Mente").tint(isMind ? .black : .gray).font(isMind ? .title : .system(size: 17))
                        }
                        Spacer()
                        Button("Tareas"){
                            isMind = false
                        }.tint(isMind ? .gray : .black).font(isMind ? .system(size: 17) : .title)
                        
                    }.padding(.init(top: 20, leading: 75, bottom: 0, trailing: 75))
                    List {
                        ForEach(tasks) { task in
                            TaskView(task:task)
                                .buttonStyle(PlainButtonStyle())
                                .listRowBackground(Color(red: 234/255, green: 250/255, blue: 254/255))
                        }
                        .onDelete(perform: deleteItems)
                    }.scrollContentBackground(.hidden)
                }
             }

//            .toolbar {
//               ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton(x)
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")}
        }
    }

    private func addItem() {
        withAnimation {
            let newTask = TaskReminder(context: viewContext)
            newTask.date = Date()
            newTask.completed = false
            newTask.name = "Tarea básica"
            newTask.notes = "Tarea sobre el destino del sabio"
            newTask.isMind = false
            newTask.id = 0
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { tasks[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

extension Button {
    func big( ) -> Button {
        return self.tint(.black) as! Button
    }
}
