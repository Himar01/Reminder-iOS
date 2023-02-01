//
//  Api.swift
//  Reminder
//
//  Created by Rita Ithaisa on 30/1/23.
//
import Foundation

class Api : ObservableObject{
    @Published var tasks = [basicTask]()
    
//    func loadData(completion:@escaping ([basicTask]?) -> ()) {
//        guard let url = URL(string: "https://json-test-75315-default-rtdb.europe-west1.firebasedatabase.app/tasks.json") else {
//            print("Invalid url...")
//            return
//        }
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            let tasks = try? JSONDecoder().decode([basicTask]?.self, from: data!)
////            print(tasks ?? "")
//            completion(tasks)
//
//        }.resume()
//
//    }
    
    func loadData(completion:@escaping ([basicTask]?) -> ()) {
        guard let url = URL(string: "https://json-test-75315-default-rtdb.europe-west1.firebasedatabase.app/tasks.json") else { fatalError("Missing URL") }

        var urlRequest = URLRequest(url: url)
        urlRequest.timeoutInterval = 10

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                print("Request error: ", error)
                completion(nil)
                return
            }
            
            
            guard let response = response as? HTTPURLResponse else { return }

            if response.statusCode == 200 {
                guard let data = data else { return }
                DispatchQueue.main.async {
                    do {
                        let decodedTasks = try JSONDecoder().decode([basicTask].self, from: data)
                        self.tasks = decodedTasks
                        completion(self.tasks)
                    } catch let error {
                        completion(nil)
                        print("Error decoding: ", error)
                    }
                }
            }
        }

        dataTask.resume()
    }
}
