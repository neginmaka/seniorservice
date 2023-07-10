//
//  requestModel.swift
//  seniorservice
//
//  Created by Negin Maka on 2023-07-08.
//

import Foundation

struct Request: Codable {
    let category: String
    let service: String
    let budget: Double
    let description: String
    let isUrgent: Bool
    let createdDate: String
    let status: String
}

