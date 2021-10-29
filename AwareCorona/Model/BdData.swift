//
//  BdData.swift
//  AwareCorona
//
//  Created by Meadown on 24/4/20.
//  Copyright © 2020 Meadown. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct BdData: Decodable {
    var get: String?
    var parameters: Parameters?
    var errors: [errors]?
    var results: Int?
    var response: [Response]?

}
//MARK: empty stack
struct errors : Decodable {
    
}
// MARK: - Parameters
struct Parameters: Decodable {
    var country: String?
}

// MARK: - Response
struct Response: Decodable {
    var country: String?
    var cases: Cases?
    var deaths: Deaths?
    var tests: Tests?
    var day: String?
    var time: String?
}

// MARK: - Cases
struct Cases: Decodable {
    var new: String?
    var active, critical, recovered, total: Int?
}

// MARK: - Deaths
struct Deaths: Decodable {
    var new: String?
    var total: Int?
}

// MARK: - Tests
struct Tests: Decodable {
    var total: Int?
}
