//
//  JsonHelper.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-07-08.
//

import Foundation

/// This is a helper to interact with the fake DB in the form of Json.
/// Once the backend is fully developed, the front-end can properly use API to connect to the actual DB.
class JsonHelper {
    func loadRequestsFromFile() -> [Request]? {
        do {
            guard let fileURL = Bundle.main.url(forResource: "requests", withExtension: "json") else {
                print("Error accessing requests.json file.")
                return nil
            }
            
            let data = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let requests = try decoder.decode([Request].self, from: data)
            return requests
        } catch {
            print("Error loading requests: \(error)")
            return nil
        }
    }




    func saveRequestsToFile(requests: [Request]) {
        do {
            guard let fileURL = Bundle.main.url(forResource: "requests", withExtension: "json") else {
                print("Error accessing requests.json file.")
                return
            }
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(requests)
            try data.write(to: fileURL)
            print("Requests saved successfully.")
        } catch {
            print("Error saving requests: \(error)")
        }
    }



}
