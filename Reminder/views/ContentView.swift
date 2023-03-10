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
    
    @StateObject private var viewModel = ViewModel()
    
    
    var body: some View {
        GeometryReader{ geo in
            NavigationView {
                VStack{
                    HStack{
                        Button {
                            viewModel.isMind = true
                        } label: {
                            Text("Mente").tint(viewModel.isMind ? .black : .lightGray).font(viewModel.isMind ? .title : .system(size: 17))
                        }
                        Spacer()
                        Button("Tareas"){
                            viewModel.isMind = false
                        }.tint(viewModel.isMind ? .lightGray : .black).font(viewModel.isMind ? .system(size: 17) : .title)
                        
                    }.padding(.init(top: 10, leading: 75, bottom: 0, trailing: 75)).frame(height: geo.size.height * 0.1)
                    List {
                        ForEach(tasks) { task in
                            if(viewModel.isMind && task.isMind || !viewModel.isMind && !task.isMind){
                                if(task.completed && viewModel.isCompleted || !task.completed && !viewModel.isCompleted){
                                    TaskView(task: task, isMind: viewModel.isMind)
                                        .buttonStyle(PlainButtonStyle())
                                        .listRowBackground(Color.taskBackground)
                                }
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }.scrollContentBackground(.hidden)
                        .frame(height: geo.size.height * 0.6)
                    Spacer()
                    ZStack{
                        VStack(spacing: 0){
                            Spacer()
                            Image("submenu_background")
                                .resizable()
                                .frame(width: geo.size.width * 1.25, height: geo.size.height * 0.3 * 0.75)
                        }
                        VStack{
                            Spacer().frame(height: geo.size.height * 0.3 * 0.08)
                            Button("Tareas completadas"){
                                viewModel.isCompleted = !viewModel.isCompleted
                            }.buttonStyle(.borderedProminent)
                                .tint(viewModel.isCompleted ? .taskCompletedBackground : .taskNotCompletedBackground)
                            HStack(){
                                VStack(){
                                    Spacer().frame(height: geo.size.height * 0.3 * 0.2)
                                    Button(){
                                        viewModel.presentAlert = true
                                    } label: {
                                        Image("menu").resizable().frame(width:30, height:30)
                                    }.alert("Caracter??stica disponible en futuras actualizaciones", isPresented: $viewModel.presentAlert){
                                        Button("OK",role: .cancel) {}
                                    }
                                }.padding(.leading, 20)
                                Spacer()
                                VStack(){
                                    NavigationLink(){
                                        ConfigTaskView(isMind: viewModel.isMind)
                                    } label: {
                                            Image("add").resizable().frame(width:60, height:60).padding(8)
                                    }.background(Color.taskBackground).cornerRadius(100).padding(.top,10).shadow(color: .lightGray, radius: 2, x: 0, y: 1)
                                    Spacer()
                                }
                                Spacer()
                                VStack(){
                                    Spacer().frame(height: geo.size.height * 0.3 * 0.2)
                                    Button(){
                                        viewModel.presentAlert = true
                                    } label:{
                                        Image("more-vert").resizable().frame(width:25, height:25)
                                    }.frame(width:30, height: 30).alert("Caracter??stica disponible en futuras actualizaciones", isPresented: $viewModel.presentAlert){
                                        Button("OK",role: .cancel) {}
                                    }
                                }.padding(.trailing, 20)
                            }.frame(width: geo.size.width)
                        }
                    }.frame(height: geo.size.height * 0.30).background{}
                }.background{if(viewModel.isMind) {Image("subway_whiter")
                        .frame(height: geo.size.height)
                    } else {Color(.white)}}
            }
        }.onAppear(){
            UserDefaults.standard.set(tasks.count, forKey: "tasksCount")
            
        }
    }
    
    
    private func addItem() {
        
        withAnimation {
            let newTask = TaskReminder(context: viewContext)
            newTask.date = Date()
            newTask.completed = viewModel.isCompleted
            newTask.name = "Tarea b??sica \(Int.random(in: 1...10)) Test\(viewModel.counter)"
            newTask.notes = "Tarea sobre el destino del sabio"
            newTask.isMind = viewModel.isMind
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



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

 
