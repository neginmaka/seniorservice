//
//  requestModel.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-07-08.
//

import Foundation

class Request: Codable {
    var category: String
    var service: String
    var budget: Double
    var description: String
    var isUrgent: Bool
    var createdDate: String
    var status: String

    init(category: String, service: String, budget: Double, description: String, isUrgent: Bool, createdDate: String, status: String) {
        self.category = category
        self.service = service
        self.budget = budget
        self.description = description
        self.isUrgent = isUrgent
        self.createdDate = createdDate
        self.status = status
    }
}
