//
//  ServerResult.swift
//  Trivia
//
//  Created by Sander de Vries on 14/12/2018.
//  Copyright © 2018 Sander de Vries. All rights reserved.
//

import Foundation

struct ServerResult: Codable {
    let id: Int
    let correct: String
    let total: String
    let time: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case correct
        case total
        case time
    }
}

typealias ServerResults = [ServerResult]

