//
//  TaskView.swift
//  Colores
//
//  Created by Rita Ithaisa on 24/11/22.
//
import Foundation
import SwiftUI

struct TaskView: View {

    var task: TaskReminder
    var body: some View {

        HStack{
            Text(task.name!).background( NavigationLink("", destination: ConfigTaskView()).opacity(0) )
            Spacer()
            Button(){
            }
                label: {
                    Image(systemName: "circle")
                }
            }
        .padding()
        .cornerRadius(15)
    }
}
