//
//  Api.swift
//  Reminder
//
//  Created by Rita Ithaisa on 30/1/23.
//
import Foundation

class Api : ObservableObject{
    @Published var tasks = [basicTask]()
    
    func loadData(completion:@escaping ([basicTask]) -> ()) {
        guard let url = URL(string: "https://json-test-75315-default-rtdb.europe-west1.firebasedatabase.app/tasks.json") else {
            print("Invalid url...")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            let tasks = try! JSONDecoder().decode([basicTask].self, from: data!)
            print(tasks)
            DispatchQueue.main.async {
                completion(tasks)
            }
        }.resume()
        
    }
}
